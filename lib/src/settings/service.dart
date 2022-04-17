import 'package:ecommerceapp/src/helpers/preferences.dart';
import 'package:ecommerceapp/src/settings/models.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class SettingsService {
  Future<Locale> getLocale() async {
    final localeString = Preferences.getString(PreferencesKey.locale);
    return localeString != null
        ? Locale(localeString)
        : AppLocalizations.supportedLocales.first;
  }

  Future<ThemeBrightness> getBrightness() async {
    final brighnessString = Preferences.getString(PreferencesKey.theme);
    return ThemeBrightness.values.firstWhere(
      (brightness) => brightness.name == brighnessString,
      orElse: () => ThemeBrightness.system,
    );
  }

  Future<void> setLocale(Locale newLocale) =>
      Preferences.setString(PreferencesKey.locale, newLocale.languageCode);

  Future<void> setBrightness(ThemeBrightness newTheme) =>
      Preferences.setString(PreferencesKey.theme, newTheme.name);
}
