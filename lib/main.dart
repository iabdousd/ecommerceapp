import 'package:ecommerceapp/firebase_options.dart';
import 'package:ecommerceapp/src/auth/controller.dart';
import 'package:ecommerceapp/src/helpers/preferences.dart';
import 'package:ecommerceapp/src/settings/controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Preferences.init();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final settingsController = SettingsController();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: settingsController),
        ChangeNotifierProvider(create: (_) => AuthController()),
      ],
      child: const App(),
    ),
  );
}
