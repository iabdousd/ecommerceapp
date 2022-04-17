import 'dart:developer';

import 'package:ecommerceapp/src/configs/navigator.dart';
import 'package:ecommerceapp/src/l10n/localization.dart';
import 'package:ecommerceapp/src/services/flushbar.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ExceptionsHandler {
  static Future<T?> handle<T>(Future<T> Function() callback) async {
    final context = AppNavigator.router.navigator!.context;
    String errorMessage;
    try {
      return await callback();
    } on FirebaseAuthException catch (e) {
      log(e.toString());
      // FirebaseCrashlytics.instance.recordError(e, s, printDetails: true);
      if (e.code == 'invalid-verification-code') {
        errorMessage = AppLocalization.of(context).codeSmsInvalid;
      } else if (e.code == 'invalid-phone-number') {
        errorMessage = AppLocalization.of(context).phoneNumberInvalid;
      } else if (e.code == 'too-many-requests') {
        errorMessage = AppLocalization.of(context).tooManySmsTriesError;
      } else if (e.code == 'network-request-failed' ||
          e.code == 'web-network-request-failed') {
        errorMessage = AppLocalization.of(context).networkError;
      } else if (e.code == 'user-disabled') {
        errorMessage = AppLocalization.of(context).unknownError;
      } else {
        errorMessage = AppLocalization.of(context).unknownError;
      }
    } catch (e) {
      // FirebaseCrashlytics.instance.recordError(e, s, printDetails: true);
      log(e.toString());
      errorMessage = AppLocalization.of(context).unknownError;
    }

    Flushbar.showError(context, errorMessage);
    return null;
  }
}
