import 'package:flutter/material.dart';

import 'my_colors_extension.dart';

class AppTheme {
  ThemeData mainLightTheme = ThemeData(
    useMaterial3: true,
    primaryColor: Color(0xFF624E88),
    highlightColor: Color(0xFF9747FF),
    disabledColor: Color(0xff654055),
    hintColor: Color(0xFFCB80AB),
    canvasColor: Color(0xFFE5E7EB),
    brightness: Brightness.light,
    textTheme: TextTheme(bodyLarge: TextStyle(color: Colors.black)),
    colorScheme: ColorScheme(
      surface: Color(0xFFE5E7EB),
      brightness: Brightness.light,
      primary: Color(0xFF624E88),
      onPrimary: Colors.black,
      secondary: Color(0xFF8967B3),
      onSecondary: Colors.black,
      tertiary: Color(0xFFE6D9A2),
      onTertiary: Colors.black45,
      error: Color(0xFFFC5757),
      onError: Colors.white,
      onSurface: Colors.black,
    ),
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

  ThemeData mainDarkTheme = ThemeData(
    useMaterial3: true,
    primaryColor: Color(0xFF624E88),
    highlightColor: Color(0xFF9747FF),
    disabledColor: Color(0xff654055),
    hintColor: Color(0xFFCB80AB),
    canvasColor: Color(0xFFE5E7EB),
    brightness: Brightness.dark,
    textTheme: TextTheme(bodyLarge: TextStyle(color: Colors.white)),
    colorScheme: ColorScheme(
      surface: Color(0xFF1f1c27),
      brightness: Brightness.dark,
      primary: Color(0xFF8967B3),
      onPrimary: Colors.white,
      secondary: Color(0xFF624E88),
      onSecondary: Colors.white,
      tertiary: Color(0xFFE6D9A2),
      onTertiary: Colors.black45,
      error: Color(0xFFFC5757),
      onError: Colors.white,
      onSurface: Colors.white,
    ),
  ).copyWith(
    extensions: <ThemeExtension<dynamic>>[
      MyColorsExtension(
        submitColor: Color(0xFF009A5E),
        onlineColor: Color(0xff00FF9C),
        disabledColor: Color(0x50CB80AB),
        offlineColor: Color(0xFFFFE700),
        translucentColor: Color(0x50624E88),
      ),
    ],
  );
}
