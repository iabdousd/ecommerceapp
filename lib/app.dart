import 'package:ecommerceapp/src/auth/controller.dart';
import 'package:ecommerceapp/src/cart/controller.dart';
import 'package:ecommerceapp/src/configs/app.dart';
import 'package:ecommerceapp/src/configs/navigator.dart';
import 'package:ecommerceapp/src/home/controller.dart';
import 'package:ecommerceapp/src/settings/controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  static final navigationKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    final settingsController = context.watch<SettingsController>();
    final userId = context.select<AuthController, String?>(
      (auth) => auth.userId,
    );

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeController()),
        ChangeNotifierProvider(create: (_) => CartController(userId)),
      ],
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: AppConfig.name,
          theme: settingsController.theme,
          locale: settingsController.locale,
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          routeInformationParser: AppNavigator.router.routeInformationParser,
          routerDelegate: AppNavigator.router.routerDelegate,
          builder: EasyLoading.init(
            builder: (context, widget) => ResponsiveWrapper.builder(
              BouncingScrollWrapper.builder(context, widget!),
              maxWidth: 1200,
              minWidth: 450,
              defaultScale: true,
              breakpoints: [
                const ResponsiveBreakpoint.resize(450, name: MOBILE),
                const ResponsiveBreakpoint.autoScale(800, name: TABLET),
                const ResponsiveBreakpoint.autoScale(1000, name: TABLET),
                const ResponsiveBreakpoint.resize(1200, name: DESKTOP),
                const ResponsiveBreakpoint.autoScale(2460, name: "4K"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
