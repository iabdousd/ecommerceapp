import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

const kDefaultPadding = 20.0;

class ThemeConfig {
  static const bodyTextLM = Color(0xFF3F3F3F);
  static const displayTextLM = Color(0xFF181818);
  static const bodyTextDM = Color(0xFFE9E9E9);
  static const displayTextDM = Color(0xFFF0F0F0);

  static const backgroundLM = Color(0xFFF1F1F1);
  static const backgroundDM = Color(0xFF000000);

  static const surfaceLM = Color(0xFFFFFFFF);
  static const onSurfaceLM = Color(0xFF2B2B2B);
  static const surfaceDM = Color(0xFF1B1B1B);
  static const onSurfaceDM = Color(0xFFE9E9E9);

  static const scaffoldBackgroundColorLM = Color(0xFFF5F6F7);
  static const scaffoldBackgroundColorDM = Color(0xFF111111);

  static const primary = Color(0xFF128BC4);
  static const onPrimary = Color(0xFFFFFFFF);

  static const secondary = Color(0xFF0E4B68);
  static const onSecondary = Color(0xFFFFFFFF);

  static const error = Color(0xFFC53A3A);
  static const onError = Color(0xFFFFFFFF);

  static const primaryGradient = LinearGradient(colors: [primary, secondary]);

  static TextTheme get textTheme => const TextTheme(
        headline1: TextStyle(fontSize: 72, fontWeight: FontWeight.bold),
        headline2: TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
        headline3: TextStyle(fontSize: 52, fontWeight: FontWeight.bold),
        headline4: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        headline5: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        headline6: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
        subtitle1: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        subtitle2: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        bodyText1: TextStyle(fontSize: 18),
        bodyText2: TextStyle(fontSize: 14),
        caption: TextStyle(fontSize: 12.5),
        overline: TextStyle(fontSize: 11),
      );

  static ThemeData lightTheme(Locale locale) => ThemeData(
        primaryColor: primary,
        backgroundColor: backgroundLM,
        scaffoldBackgroundColor: scaffoldBackgroundColorLM,
        colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: primary,
          onPrimary: onPrimary,
          secondary: secondary,
          onSecondary: onSecondary,
          error: error,
          onError: onError,
          background: backgroundLM,
          onBackground: bodyTextLM,
          surface: surfaceLM,
          onSurface: onSurfaceLM,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          foregroundColor: displayTextLM,
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          toolbarHeight: kToolbarHeight,
        ),
        listTileTheme: const ListTileThemeData(iconColor: bodyTextLM),
        textTheme: (locale.languageCode == 'ar'
                ? GoogleFonts.ibmPlexSansArabicTextTheme(textTheme)
                : GoogleFonts.poppinsTextTheme(textTheme))
            .apply(bodyColor: bodyTextLM, displayColor: displayTextLM),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: backgroundLM,
          selectedItemColor: primary,
          unselectedItemColor: displayTextLM,
          type: BottomNavigationBarType.fixed,
        ),
        dividerColor: displayTextLM,
        cardTheme: const CardTheme(
          color: surfaceLM,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
        ),
      );

  static ThemeData darkTheme(Locale locale) => ThemeData.dark().copyWith(
        primaryColor: primary,
        backgroundColor: backgroundDM,
        scaffoldBackgroundColor: scaffoldBackgroundColorDM,
        colorScheme: const ColorScheme.dark(
          brightness: Brightness.light,
          primary: primary,
          onPrimary: onPrimary,
          secondary: secondary,
          onSecondary: onSecondary,
          error: error,
          onError: onError,
          background: backgroundDM,
          onBackground: bodyTextDM,
          surface: surfaceDM,
          onSurface: onSurfaceDM,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          foregroundColor: displayTextDM,
          toolbarHeight: kToolbarHeight,
        ),
        listTileTheme: const ListTileThemeData(iconColor: bodyTextDM),
        textTheme: (locale.languageCode == 'ar'
                ? GoogleFonts.ibmPlexSansArabicTextTheme(textTheme)
                : GoogleFonts.poppinsTextTheme(textTheme))
            .apply(bodyColor: bodyTextDM, displayColor: displayTextDM),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: backgroundDM,
          selectedItemColor: primary,
          unselectedItemColor: displayTextDM,
          type: BottomNavigationBarType.fixed,
        ),
        dividerColor: displayTextDM,
        cardTheme: const CardTheme(
          color: surfaceDM,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
        ),
      );
}

class DefaultBoxShadow extends BoxShadow {
  final bool small;
  const DefaultBoxShadow({this.small = false})
      : super(
          color: small ? const Color(0x18000000) : const Color(0x24000000),
          blurRadius: small ? 8 : 16,
          blurStyle: BlurStyle.outer,
        );
}
