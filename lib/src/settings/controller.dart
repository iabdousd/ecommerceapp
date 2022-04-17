import 'package:ecommerceapp/src/configs/theme.dart';
import 'package:ecommerceapp/src/settings/service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'models.dart';

class SettingsController with ChangeNotifier {
  static Locale localeOf(BuildContext context) =>
      context.select<SettingsController, Locale>(
        (controller) => controller.locale,
      );

  final SettingsService service;
  late Locale _locale;
  Locale get locale => _locale;
  late ThemeBrightness brightness;

  set locale(Locale? newLocale) {
    if (newLocale == null) return;
    _locale = newLocale;
    Intl.defaultLocale = newLocale.languageCode;
    notifyListeners();
    service.setLocale(newLocale);
  }

  SettingsController() : service = SettingsService() {
    init();
  }

  void init() async {
    locale = await service.getLocale();
    brightness = await service.getBrightness();
  }

  Future<void> setBrightness(ThemeBrightness? newBrightness) {
    if (newBrightness == null) return Future.value();

    brightness = newBrightness;
    notifyListeners();
    return service.setBrightness(newBrightness);
  }

  ThemeData get theme => brightness == ThemeBrightness.light
      ? ThemeConfig.lightTheme(locale)
      : ThemeConfig.darkTheme(locale);
}
