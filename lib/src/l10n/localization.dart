import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class AppLocalization {
  static const supportedLocales = [Locale('ar'), Locale('en'), Locale('fr')];

  static AppLocalizations of(BuildContext context) =>
      AppLocalizations.of(context)!;
}
