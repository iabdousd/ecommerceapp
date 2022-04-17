import 'package:ecommerceapp/src/l10n/localization.dart';
import 'package:flutter/material.dart';

enum ThemeBrightness { system, light, dark }

extension ThemeBrightnessExt on ThemeBrightness {
  String title(BuildContext context) {
    switch (this) {
      case ThemeBrightness.system:
        return AppLocalization.of(context).system;
      case ThemeBrightness.light:
        return AppLocalization.of(context).light;
      case ThemeBrightness.dark:
        return AppLocalization.of(context).dark;
    }
  }
}

extension LocaleExt on Locale {
  String get title {
    switch (languageCode) {
      case 'ar':
        return 'العربية';
      case 'en':
        return 'English';
      case 'fr':
        return 'Français';
      default:
        return '';
    }
  }
}
