import 'package:flutter/material.dart';
import 'package:mcda_app/classes/app_constants.dart';

import '../classes/my_colors_extension.dart';
import '../provider/theme.dart';

ThemeData? themeChanger(
  ThemeNotifier themeNotifier,
  ColorScheme? lightDynamic,
  ColorScheme? darkDynamic,
) {
  final theme = themeNotifier.theme;
  final scheme = themeNotifier.colorScheme;

  if (theme == 'light') {
    switch (scheme) {
      case 'red':
        return AppConstants().mainLightTheme;
      case 'blue':
        return AppConstants().mainLightTheme;
      case 'main':
        return AppConstants().mainLightTheme;
      case 'dynamic':
        return ThemeData(
          useMaterial3: true,
          brightness: Brightness.light,
          colorScheme: lightDynamic!,
          textTheme: TextTheme(bodyLarge: TextStyle(color: Colors.black)),
        ).copyWith(
          extensions: <ThemeExtension<dynamic>>[
            MyColorsExtension(
              submitColor: Color(0xFF009A5E),
              onlineColor: Color(0xff00FF9C),
              disabledColor: Color(0x50CB80AB),
              offlineColor: Color(0xFFFFE700),
              translucentColor: Color(0x508967B3),
            ),
          ],
        );
      default:
        return AppConstants().mainLightTheme;
    }
  } else if (theme == 'dark') {
    switch (scheme) {
      case 'red':
        return AppConstants().mainDarkTheme;
      case 'blue':
        return AppConstants().mainDarkTheme;
      case 'main':
        return AppConstants().mainDarkTheme;
      case 'dynamic':
        return ThemeData(
          useMaterial3: true,
          brightness: Brightness.dark,
          colorScheme: darkDynamic!,
          textTheme: TextTheme(bodyLarge: TextStyle(color: Colors.white)),
        ).copyWith(
          extensions: <ThemeExtension<dynamic>>[
            MyColorsExtension(
              submitColor: Color(0xFF009A5E),
              onlineColor: Color(0xff00FF9C),
              disabledColor: Color(0x50CB80AB),
              offlineColor: Color(0xFFFFE700),
              translucentColor: Color(0x508967B3),
            ),
          ],
        );
      default:
        return AppConstants().mainDarkTheme;
    }
  }

  return AppConstants().mainLightTheme;
}
