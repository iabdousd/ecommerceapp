import 'package:ecommerceapp/src/l10n/localization.dart';
import 'package:flutter/material.dart';

class FormValidators {
  static String? name(BuildContext context, String? value) {
    if (value != null && value.isNotEmpty) return null;
    return AppLocalization.of(context).fieldRequired;
  }

  static FormFieldValidator<String> phone(BuildContext context) =>
      (String? value) {
        const pattern = r'(^[0-9]*$)';
        final regExp = RegExp(pattern);
        if (value == null || value.isEmpty) {
          return AppLocalization.of(context).fieldRequired;
        } else if (!regExp.hasMatch(value) || value.length != 8) {
          return AppLocalization.of(context).phoneNumberInvalid;
        }
        return null;
      };
}
