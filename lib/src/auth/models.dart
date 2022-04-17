import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerceapp/src/l10n/localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

enum UserGender { male, female }

extension UserGenderExtension on UserGender {
  String name(BuildContext context) {
    if (this == UserGender.male) return AppLocalization.of(context).male;

    return AppLocalization.of(context).female;
  }

  String get asString => describeEnum(this);

  static UserGender fromString(String string) => UserGender.values.firstWhere(
        (gender) => gender.asString == string,
      );
}

class UserModel {
  final String id;
  final String name;
  final String phoneNumber;
  final String? profilePicture;
  final UserGender gender;
  final double balance;
  final List<String> fcmTokens;

  UserModel({
    required this.id,
    required this.name,
    required this.phoneNumber,
    this.profilePicture,
    required this.gender,
    this.balance = 0.0,
    this.fcmTokens = const [],
  });

  Map<String, dynamic> get toMap => {
        'uid': id,
        'fullName': name,
        'phoneNumber': phoneNumber,
        'profilePicture': profilePicture,
        'sex': gender.asString,
      };

  factory UserModel.fromSnap(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data()!;

    return UserModel(
      id: snapshot.id,
      name: data['fullName'],
      phoneNumber: data['phoneNumber'],
      profilePicture: data['profilePicture'],
      gender: UserGenderExtension.fromString(data['sex']),
      balance: data['balance']?.toDouble() ?? 0.0,
      fcmTokens: List<String>.from(data['fcmTokens'] ?? []),
    );
  }
}
