import 'dart:io';

import 'package:ecommerceapp/src/auth/models.dart';
import 'package:ecommerceapp/src/auth/service.dart';
import 'package:ecommerceapp/src/auth/views/register.dart';
import 'package:ecommerceapp/src/auth/views/verify_otp.dart';
import 'package:ecommerceapp/src/auth/views/view.dart';
import 'package:ecommerceapp/src/landing/view.dart';
import 'package:ecommerceapp/src/services/exceptions.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:image/image.dart' as image;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:path_provider/path_provider.dart';

enum AuthState { authentication, verification, update }

class AuthController with ChangeNotifier {
  final _authServices = AuthService();
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  CollectionReference<Map<String, dynamic>> get _usersCollection =>
      _firestore.collection('users');

  AuthState currentState = AuthState.authentication;
  String? get userId => _auth.currentUser?.uid;
  bool get isAuthenticated => userId != null;
  final authInputModel = _AuthInputsModel();
  UserModel? _user;
  UserModel get user => _user!;

  Future<void> init(BuildContext context) async {
    EasyLoading.instance
      ..backgroundColor = Theme.of(context).primaryColor
      ..progressColor = Theme.of(context).primaryColor
      ..userInteractions = false
      ..indicatorType = EasyLoadingIndicatorType.fadingCircle;

    if (isAuthenticated) {
      await checkIfRegisterCompleted(context);
    } else {
      await Future.delayed(const Duration(milliseconds: 1700));
      pushToAuth(context);
    }
  }

  void verifyPhoneNumber(
    BuildContext context, {
    String? customPhoneNumber,
  }) async {
    if (!authInputModel.phoneFieldKey.currentState!.validate()) return;

    EasyLoading.show();
    await ExceptionsHandler.handle(
      () async {
        await _auth.verifyPhoneNumber(
          phoneNumber:
              '+222${(customPhoneNumber ?? authInputModel.phoneNumberController.text).replaceAll('+222', '')}',
          codeSent: (String verificationId, int? forceResendingToken) {
            authInputModel.verificationId = verificationId;
            context.go(VerifyOtpView.buildRouteName());
          },
          verificationCompleted: (credential) async {
            EasyLoading.show();
            await _signinWithCredential(credential);
            await checkIfRegisterCompleted(context, false);
            EasyLoading.dismiss();
          },
          codeAutoRetrievalTimeout: (String verificationId) {},
          verificationFailed: (error) => ExceptionsHandler.handle(
            () async => throw error,
          ),
        );
      },
    );
    EasyLoading.dismiss();
  }

  void verifySmsCode(BuildContext context) async {
    EasyLoading.show();
    await ExceptionsHandler.handle(
      () async {
        final credential = PhoneAuthProvider.credential(
          verificationId: authInputModel.verificationId,
          smsCode: authInputModel.smsCode,
        );

        switch (currentState) {
          case AuthState.authentication:
            {
              await _signinWithCredential(credential);
              await checkIfRegisterCompleted(context, false);
              break;
            }
          case AuthState.verification:
            {
              await _signinWithCredential(credential);
              currentState = AuthState.update;
              verifyPhoneNumber(context);
              break;
            }
          case AuthState.update:
            {
              await _auth.currentUser!.updatePhoneNumber(credential);
              _updateProfileData(context);
              break;
            }
        }
      },
    );
    EasyLoading.dismiss();
  }

  Future<void> checkIfRegisterCompleted(
    BuildContext context, [
    bool waitForSplash = true,
  ]) async {
    late DocumentSnapshot<Map<String, dynamic>> userDoc;
    await Future.wait([
      _usersCollection.doc(userId).get().then((value) => userDoc = value),
      if (waitForSplash) Future.delayed(const Duration(milliseconds: 1700)),
    ]);

    if (userDoc.exists) {
      _user = UserModel.fromSnap(userDoc);
      _usersCollection.doc(userId).snapshots().listen((snap) {
        _user = UserModel.fromSnap(snap);
        notifyListeners();
      });

      pushToLanding(context);
      final token = await _authServices.getToken();
      if (token != null && !_user!.fcmTokens.contains(token)) {
        await _usersCollection.doc(userId).update({
          'fcmTokens': FieldValue.arrayUnion([token])
        });
      }
    } else {
      context.go(RegisterView.buildRouteName());
    }
  }

  Future<void> _signinWithCredential(PhoneAuthCredential credential) =>
      _auth.signInWithCredential(credential);

  void createAccount(BuildContext context) async {
    if (!authInputModel.registerFormKey.currentState!.validate()) return;

    EasyLoading.show();
    await ExceptionsHandler.handle(() async {
      final user = UserModel(
        id: userId!,
        name: authInputModel.nameController.text,
        phoneNumber: authInputModel.phoneNumberController.text,
        gender: authInputModel.gender,
      );

      await _firestore.collection('users').doc(userId).set(user.toMap);
      await checkIfRegisterCompleted(context, false);
    });
    EasyLoading.dismiss();
  }

  void pushToLanding(BuildContext context) => context.go(LandingView.routeName);

  void pushToAuth(BuildContext context) => context.go(AuthView.routeName);

  void logout(BuildContext context) async {
    EasyLoading.show();
    final token = await _authServices.getToken();
    if (token != null) {
      await _usersCollection.doc(userId).update({
        'fcmTokens': FieldValue.arrayRemove([token])
      });
    }
    await _auth.signOut();
    _user = null;
    pushToAuth(context);
    EasyLoading.dismiss();
  }

  void initForProfile() {
    authInputModel.nameController.text = user.name;
    authInputModel.phoneNumberController.text = user.phoneNumber;
  }

  void editProfile(BuildContext context, File? imageFile) async {
    if (!authInputModel.registerFormKey.currentState!.validate()) return;
    EasyLoading.show();
    await ExceptionsHandler.handle(() async {
      authInputModel.imageFile = imageFile;
      if (user.phoneNumber != authInputModel.phoneNumberController.text) {
        currentState = AuthState.verification;
        verifyPhoneNumber(context, customPhoneNumber: user.phoneNumber);
      } else {
        _updateProfileData(context);
      }
    });
  }

  void _updateProfileData(BuildContext context) async {
    String? image;
    if (authInputModel.imageFile != null) {
      image = await uploadImage(authInputModel.imageFile);
    }
    await _usersCollection.doc(userId).update({
      'fullName': authInputModel.nameController.text,
      'phoneNumber': authInputModel.phoneNumberController.text,
      if (image != null) 'profilePicture': image,
    });
    EasyLoading.dismiss();
    pushToLanding(context);
  }

  Future<String?> uploadImage(File? imageFile) async {
    if (imageFile == null) return null;

    final tempPath = (await getTemporaryDirectory()).path;
    image.Image? decodedImage = image.decodeImage(imageFile.readAsBytesSync());
    if (decodedImage == null) return null;

    image.Image smallerImage = image.copyResize(decodedImage, width: 200);
    imageFile = File('$tempPath/tempFile.jpg')
      ..writeAsBytesSync(image.encodeJpg(smallerImage));

    final storageSnap = await FirebaseStorage.instance
        .ref('clients/')
        .child('${user.id}.jpg')
        .putFile(imageFile);

    return await storageSnap.ref.getDownloadURL();
  }
}

class _AuthInputsModel {
  final phoneFieldKey = GlobalKey<FormFieldState>();
  final registerFormKey = GlobalKey<FormState>();

  final phoneNumberController = TextEditingController(),
      nameController = TextEditingController();
  late String verificationId;
  File? imageFile;
  String smsCode = '';
  UserGender gender = UserGender.male;
}
