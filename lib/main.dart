import 'package:ecommerceapp/firebase_options.dart';
import 'package:ecommerceapp/helpers/preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app.dart';
import 'settings/controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Preferences.init();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final settingsController = SettingsController();

  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider.value(value: settingsController)],
      child: const App(),
    ),
  );
}
