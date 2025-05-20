import 'package:flutter/material.dart';
import 'package:mcda_app/core/configs/theme/app_theme.dart';

import '../../provider/theme.dart';
import 'my_colors_extension.dart';

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
        return AppTheme().mainLightTheme;
      case 'blue':
        return AppTheme().mainLightTheme;
      case 'main':
        return AppTheme().mainLightTheme;
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
              translucentColor: lightDynamic.primaryContainer,
            ),
          ],
        );
      default:
        return AppTheme().mainLightTheme;
    }
  } else if (theme == 'dark') {
    switch (scheme) {
      case 'red':
        return AppTheme().mainDarkTheme;
      case 'blue':
        return AppTheme().mainDarkTheme;
      case 'main':
        return AppTheme().mainDarkTheme;
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
              translucentColor: darkDynamic.primaryContainer,
            ),
          ],
        );
      default:
        return AppTheme().mainDarkTheme;
    }
  }

  return AppTheme().mainLightTheme;
}
