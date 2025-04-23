import 'package:flutter/material.dart';

import 'my_colors_extension.dart';

class AppConstants {
  ThemeData mainLightTheme = ThemeData(
    brightness: Brightness.dark,
    textTheme: TextTheme(bodyLarge: TextStyle(color: Colors.white)),
  ).copyWith(
    extensions: <ThemeExtension<dynamic>>[
      MyColorsExtension(
        primaryColor: Color(0xFF624E88),
        secondaryColor: Color(0xFF8967B3),
        backgroundColor: Color(0xFFE5E7EB),
        accentColor: Color(0xFFCB80AB),
        tertiaryColor: Color(0xFFE6D9A2),
        submitColor: Color(0xFF009A5E),
        cancelColor: Color(0xFFFC5757),
        onlineColor: Color(0xff00FF9C),
        disabledColor: Color(0x50CB80AB),
        errorColor: Color(0xFFFC5757),
        offlineColor: Color(0xFFFFE700),
        translucentColor: Color(0x508967B3),
      ),
    ],
  );

  ThemeData mainDarkTheme = ThemeData(
    brightness: Brightness.dark,
    textTheme: TextTheme(bodyLarge: TextStyle(color: Colors.white)),
  ).copyWith(
    extensions: <ThemeExtension<dynamic>>[
      MyColorsExtension(
        primaryColor: Colors.black,
        secondaryColor: Colors.black,
        backgroundColor: Colors.black,
        accentColor: Colors.black,
        tertiaryColor: Colors.black,
        submitColor: Colors.black,
        cancelColor: Colors.black,
        onlineColor: Colors.black,
        disabledColor: Colors.black,
        errorColor: Colors.black,
        offlineColor: Colors.black,
        translucentColor: Colors.black,
      ),
    ],
  );
}
