import 'package:flutter/material.dart';

import 'my_colors_extension.dart';

class AppTheme {
  final ColorScheme? darkDynamic;
  final ColorScheme? lightDynamic;
  AppTheme({required this.darkDynamic, required this.lightDynamic});

  ThemeData mainLightTheme = ThemeData(
    useMaterial3: true,
    primaryColor: Color(0xFF624E88),
    highlightColor: Color(0xFF9747FF),
    disabledColor: Color(0xff654055),
    hintColor: Color(0xFFCB80AB),
    canvasColor: Color(0xFFE5E7EB),
    brightness: Brightness.light,
    textTheme: TextTheme().apply(
      bodyColor: Colors.black,
      displayColor: Colors.black,
    ),
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
    textTheme: TextTheme().apply(
      bodyColor: Colors.black,
      displayColor: Colors.black,
    ),
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

  ThemeData get dynamicLight => ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: lightDynamic,
    textTheme: TextTheme(bodyLarge: TextStyle(color: Colors.black)),
  ).copyWith(
    extensions: <ThemeExtension<dynamic>>[
      MyColorsExtension(
        submitColor: Color(0xFF009A5E),
        onlineColor: Color(0xff00FF9C),
        disabledColor: Color(0x50CB80AB),
        offlineColor: Color(0xFFFFE700),
        translucentColor: lightDynamic?.primaryContainer,
      ),
    ],
  );

  ThemeData get dynamicDark => ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: darkDynamic,
    textTheme: TextTheme(bodyLarge: TextStyle(color: Colors.white)),
  ).copyWith(
    extensions: <ThemeExtension<dynamic>>[
      MyColorsExtension(
        submitColor: Color(0xFF009A5E),
        onlineColor: Color(0xff00FF9C),
        disabledColor: Color(0x50CB80AB),
        offlineColor: Color(0xFFFFE700),
        translucentColor: darkDynamic?.primaryContainer,
      ),
    ],
  );

  ThemeData iosLightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: Color(0xFF007AFF), // iOS Blue
    scaffoldBackgroundColor: Color(0xFFF9F9F9), // iOS system background
    canvasColor: Color(0xFFFFFFFF),
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xFF007AFF), // iOS Blue
      onPrimary: Colors.white,
      secondary: Color(0xFF5856D6), // iOS Purple
      onSecondary: Colors.white,
      surface: Color(0xFFFFFFFF),
      onSurface: Color(0xFF1C1C1E),
      error: Color(0xFFFF3B30), // iOS Red
      onError: Colors.white,
      tertiary: Color(0xFF34C759), // iOS Green
      onTertiary: Colors.white,
    ),
    textTheme: TextTheme().apply(
      bodyColor: Color(0xFF1C1C1E),
      displayColor: Color(0xFF1C1C1E),
    ),
  ).copyWith(
    extensions: <ThemeExtension<dynamic>>[
      MyColorsExtension(
        submitColor: Color(0xFF009A5E),
        onlineColor: Color(0xff00FF9C),
        disabledColor: Color(0x50CB80AB),
        offlineColor: Color(0xFFFFE700),
        translucentColor: Color(0x500A84FF),
      ),
    ],
  );

  final ThemeData iosDarkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: Color(0xFF0A84FF), // iOS Blue (Dark)
    scaffoldBackgroundColor: Color(0xFF000000), // iOS system background dark
    canvasColor: Color(0xFF1C1C1E),
    colorScheme: ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xFF0A84FF), // iOS Blue (Dark)
      onPrimary: Colors.white,
      secondary: Color(0xFF5E5CE6), // iOS Purple (Dark)
      onSecondary: Colors.white,
      surface: Color(0xFF1C1C1E),
      onSurface: Color(0xFFF2F2F7),
      error: Color(0xFFFF453A), // iOS Red (Dark)
      onError: Colors.white,
      tertiary: Color(0xFF30D158), // iOS Green (Dark)
      onTertiary: Colors.white,
    ),
    textTheme: TextTheme().apply(
      bodyColor: Color(0xFFF2F2F7),
      displayColor: Color(0xFFF2F2F7),
    ),
  ).copyWith(
    extensions: <ThemeExtension<dynamic>>[
      MyColorsExtension(
        submitColor: Color(0xFF009A5E),
        onlineColor: Color(0xff00FF9C),
        disabledColor: Color(0x50CB80AB),
        offlineColor: Color(0xFFFFE700),
        translucentColor: Color(0x500A84FF),
      ),
    ],
  );

  final ThemeData blueLightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: Color(0xFF1976D2), // Blue 700
    scaffoldBackgroundColor: Color(0xFFF5F8FD), // Light blue background
    canvasColor: Color(0xFFFFFFFF),
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xFF1976D2), // Blue 700
      onPrimary: Colors.white,
      secondary: Color(0xFF42A5F5), // Blue 400
      onSecondary: Colors.white,
      surface: Color(0xFFFFFFFF),
      onSurface: Color(0xFF0D1333),
      error: Color(0xFFD32F2F), // Red 700
      onError: Colors.white,
      tertiary: Color(0xFF90CAF9), // Blue 200
      onTertiary: Colors.black,
    ),
    textTheme: TextTheme().apply(
      bodyColor: Color(0xFF0D1333),
      displayColor: Color(0xFF0D1333),
    ),
  ).copyWith(
    extensions: <ThemeExtension<dynamic>>[
      MyColorsExtension(
        submitColor: Color(0xFF1976D2),
        onlineColor: Color(0xFF42A5F5),
        disabledColor: Color(0x502196F3),
        offlineColor: Color(0xFF90CAF9),
        translucentColor: Color(0x501976D2),
      ),
    ],
  );

  final ThemeData blueDarkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: Color(0xFF2196F3), // Blue 500
    scaffoldBackgroundColor: Color(0xFF121A2B), // Dark blue background
    canvasColor: Color(0xFF1A237E), // Indigo 900
    colorScheme: ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xFF2196F3), // Blue 500
      onPrimary: Colors.white,
      secondary: Color(0xFF64B5F6), // Blue 300
      onSecondary: Colors.white,
      surface: Color(0xFF1A237E), // Indigo 900
      onSurface: Color(0xFFE3F2FD),
      error: Color(0xFFEF5350), // Red 400
      onError: Colors.white,
      tertiary: Color(0xFF90CAF9), // Blue 200
      onTertiary: Colors.black,
    ),
    textTheme: TextTheme().apply(
      bodyColor: Color(0xFFE3F2FD),
      displayColor: Color(0xFFE3F2FD),
    ),
  ).copyWith(
    extensions: <ThemeExtension<dynamic>>[
      MyColorsExtension(
        submitColor: Color(0xFF2196F3),
        onlineColor: Color(0xFF64B5F6),
        disabledColor: Color(0x502196F3),
        offlineColor: Color(0xFF90CAF9),
        translucentColor: Color(0x502196F3),
      ),
    ],
  );

  // GREEN
  final ThemeData greenLightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: Color(0xFF43A047), // Green 600
    scaffoldBackgroundColor: Color(0xFFF1F8E9), // Light green background
    canvasColor: Color(0xFFFFFFFF),
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xFF43A047),
      onPrimary: Colors.white,
      secondary: Color(0xFF66BB6A), // Green 400
      onSecondary: Colors.white,
      surface: Color(0xFFFFFFFF),
      onSurface: Color(0xFF1B5E20),
      error: Color(0xFFD32F2F),
      onError: Colors.white,
      tertiary: Color(0xFFA5D6A7),
      onTertiary: Colors.black,
    ),
    textTheme: TextTheme().apply(
      bodyColor: Color(0xFF1B5E20),
      displayColor: Color(0xFF1B5E20),
    ),
  ).copyWith(
    extensions: <ThemeExtension<dynamic>>[
      MyColorsExtension(
        submitColor: Color(0xFF43A047),
        onlineColor: Color(0xFF66BB6A),
        disabledColor: Color(0x5043A047),
        offlineColor: Color(0xFFA5D6A7),
        translucentColor: Color(0x5043A047),
      ),
    ],
  );

  final ThemeData greenDarkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: Color(0xFF66BB6A),
    scaffoldBackgroundColor: Color(0xFF263238),
    canvasColor: Color(0xFF1B5E20),
    colorScheme: ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xFF66BB6A),
      onPrimary: Colors.white,
      secondary: Color(0xFF43A047),
      onSecondary: Colors.white,
      surface: Color(0xFF1B5E20),
      onSurface: Color(0xFFC8E6C9),
      error: Color(0xFFEF5350),
      onError: Colors.white,
      tertiary: Color(0xFFA5D6A7),
      onTertiary: Colors.black,
    ),
    textTheme: TextTheme().apply(
      bodyColor: Color(0xFFC8E6C9),
      displayColor: Color(0xFFC8E6C9),
    ),
  ).copyWith(
    extensions: <ThemeExtension<dynamic>>[
      MyColorsExtension(
        submitColor: Color(0xFF66BB6A),
        onlineColor: Color(0xFF43A047),
        disabledColor: Color(0x5066BB6A),
        offlineColor: Color(0xFFA5D6A7),
        translucentColor: Color(0x5066BB6A),
      ),
    ],
  );

  // RED
  final ThemeData redLightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: Color(0xFFD32F2F),
    scaffoldBackgroundColor: Color(0xFFFFEBEE),
    canvasColor: Color(0xFFFFFFFF),
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xFFD32F2F),
      onPrimary: Colors.white,
      secondary: Color(0xFFEF5350),
      onSecondary: Colors.white,
      surface: Color(0xFFFFFFFF),
      onSurface: Color(0xFFB71C1C),
      error: Color(0xFFD32F2F),
      onError: Colors.white,
      tertiary: Color(0xFFFFCDD2),
      onTertiary: Colors.black,
    ),
    textTheme: TextTheme().apply(
      bodyColor: Color(0xFFB71C1C),
      displayColor: Color(0xFFB71C1C),
    ),
  ).copyWith(
    extensions: <ThemeExtension<dynamic>>[
      MyColorsExtension(
        submitColor: Color(0xFFD32F2F),
        onlineColor: Color(0xFFEF5350),
        disabledColor: Color(0x50D32F2F),
        offlineColor: Color(0xFFFFCDD2),
        translucentColor: Color(0x50D32F2F),
      ),
    ],
  );

  final ThemeData redDarkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: Color(0xFFEF5350),
    scaffoldBackgroundColor: Color(0xFF212121),
    canvasColor: Color(0xFFB71C1C),
    colorScheme: ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xFFEF5350),
      onPrimary: Colors.white,
      secondary: Color(0xFFD32F2F),
      onSecondary: Colors.white,
      surface: Color(0xFFB71C1C),
      onSurface: Color(0xFFFFCDD2),
      error: Color(0xFFD32F2F),
      onError: Colors.white,
      tertiary: Color(0xFFFFCDD2),
      onTertiary: Colors.black,
    ),
    textTheme: TextTheme().apply(
      bodyColor: Color(0xFFFFCDD2),
      displayColor: Color(0xFFFFCDD2),
    ),
  ).copyWith(
    extensions: <ThemeExtension<dynamic>>[
      MyColorsExtension(
        submitColor: Color(0xFFEF5350),
        onlineColor: Color(0xFFD32F2F),
        disabledColor: Color(0x50EF5350),
        offlineColor: Color(0xFFFFCDD2),
        translucentColor: Color(0x50EF5350),
      ),
    ],
  );

  // YELLOW
  final ThemeData yellowLightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: Color(0xFFFFB300),
    scaffoldBackgroundColor: Color(0xFFFFFDE7),
    canvasColor: Color(0xFFFFFFFF),
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xFFFFB300),
      onPrimary: Colors.black,
      secondary: Color(0xFFFFF176),
      onSecondary: Colors.black,
      surface: Color(0xFFFFFFFF),
      onSurface: Color(0xFFF57C00),
      error: Color(0xFFD32F2F),
      onError: Colors.white,
      tertiary: Color(0xFFFFF9C4),
      onTertiary: Colors.black,
    ),
    textTheme: TextTheme().apply(
      bodyColor: Color(0xFFF57C00),
      displayColor: Color(0xFFF57C00),
    ),
  ).copyWith(
    extensions: <ThemeExtension<dynamic>>[
      MyColorsExtension(
        submitColor: Color(0xFFFFB300),
        onlineColor: Color(0xFFFFF176),
        disabledColor: Color(0x50FFB300),
        offlineColor: Color(0xFFFFF9C4),
        translucentColor: Color(0x50FFB300),
      ),
    ],
  );

  final ThemeData yellowDarkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: Color(0xFFFFF176),
    scaffoldBackgroundColor: Color(0xFF212121),
    canvasColor: Color(0xFFF57C00),
    colorScheme: ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xFFFFF176),
      onPrimary: Colors.black,
      secondary: Color(0xFFFFB300),
      onSecondary: Colors.black,
      surface: Color(0xFFF57C00),
      onSurface: Color(0xFFFFF9C4),
      error: Color(0xFFD32F2F),
      onError: Colors.white,
      tertiary: Color(0xFFFFF9C4),
      onTertiary: Colors.black,
    ),
    textTheme: TextTheme().apply(
      bodyColor: Color(0xFFFFF9C4),
      displayColor: Color(0xFFFFF9C4),
    ),
  ).copyWith(
    extensions: <ThemeExtension<dynamic>>[
      MyColorsExtension(
        submitColor: Color(0xFFFFF176),
        onlineColor: Color(0xFFFFB300),
        disabledColor: Color(0x50FFF176),
        offlineColor: Color(0xFFFFF9C4),
        translucentColor: Color(0x50FFF176),
      ),
    ],
  );

  // PURPLE
  final ThemeData purpleLightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: Color(0xFF8E24AA),
    scaffoldBackgroundColor: Color(0xFFF3E5F5),
    canvasColor: Color(0xFFFFFFFF),
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xFF8E24AA),
      onPrimary: Colors.white,
      secondary: Color(0xFFBA68C8),
      onSecondary: Colors.white,
      surface: Color(0xFFFFFFFF),
      onSurface: Color(0xFF4A148C),
      error: Color(0xFFD32F2F),
      onError: Colors.white,
      tertiary: Color(0xFFE1BEE7),
      onTertiary: Colors.black,
    ),
    textTheme: TextTheme().apply(
      bodyColor: Color(0xFF4A148C),
      displayColor: Color(0xFF4A148C),
    ),
  ).copyWith(
    extensions: <ThemeExtension<dynamic>>[
      MyColorsExtension(
        submitColor: Color(0xFF8E24AA),
        onlineColor: Color(0xFFBA68C8),
        disabledColor: Color(0x508E24AA),
        offlineColor: Color(0xFFE1BEE7),
        translucentColor: Color(0x508E24AA),
      ),
    ],
  );

  final ThemeData purpleDarkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: Color(0xFFBA68C8),
    scaffoldBackgroundColor: Color(0xFF212121),
    canvasColor: Color(0xFF4A148C),
    colorScheme: ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xFFBA68C8),
      onPrimary: Colors.white,
      secondary: Color(0xFF8E24AA),
      onSecondary: Colors.white,
      surface: Color(0xFF4A148C),
      onSurface: Color(0xFFE1BEE7),
      error: Color(0xFFD32F2F),
      onError: Colors.white,
      tertiary: Color(0xFFE1BEE7),
      onTertiary: Colors.black,
    ),
    textTheme: TextTheme().apply(
      bodyColor: Color(0xFFE1BEE7),
      displayColor: Color(0xFFE1BEE7),
    ),
  ).copyWith(
    extensions: <ThemeExtension<dynamic>>[
      MyColorsExtension(
        submitColor: Color(0xFFBA68C8),
        onlineColor: Color(0xFF8E24AA),
        disabledColor: Color(0x50BA68C8),
        offlineColor: Color(0xFFE1BEE7),
        translucentColor: Color(0x50BA68C8),
      ),
    ],
  );

  // ORANGE
  final ThemeData orangeLightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: Color(0xFFF57C00),
    scaffoldBackgroundColor: Color(0xFFFFF3E0),
    canvasColor: Color(0xFFFFFFFF),
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xFFF57C00),
      onPrimary: Colors.white,
      secondary: Color(0xFFFFA726),
      onSecondary: Colors.white,
      surface: Color(0xFFFFFFFF),
      onSurface: Color(0xFFE65100),
      error: Color(0xFFD32F2F),
      onError: Colors.white,
      tertiary: Color(0xFFFFE0B2),
      onTertiary: Colors.black,
    ),
    textTheme: TextTheme().apply(
      bodyColor: Color(0xFFE65100),
      displayColor: Color(0xFFE65100),
    ),
  ).copyWith(
    extensions: <ThemeExtension<dynamic>>[
      MyColorsExtension(
        submitColor: Color(0xFFF57C00),
        onlineColor: Color(0xFFFFA726),
        disabledColor: Color(0x50F57C00),
        offlineColor: Color(0xFFFFE0B2),
        translucentColor: Color(0x50F57C00),
      ),
    ],
  );

  final ThemeData orangeDarkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: Color(0xFFFFA726),
    scaffoldBackgroundColor: Color(0xFF212121),
    canvasColor: Color(0xFFE65100),
    colorScheme: ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xFFFFA726),
      onPrimary: Colors.white,
      secondary: Color(0xFFF57C00),
      onSecondary: Colors.white,
      surface: Color(0xFFE65100),
      onSurface: Color(0xFFFFE0B2),
      error: Color(0xFFD32F2F),
      onError: Colors.white,
      tertiary: Color(0xFFFFE0B2),
      onTertiary: Colors.black,
    ),
    textTheme: TextTheme().apply(
      bodyColor: Color(0xFFFFE0B2),
      displayColor: Color(0xFFFFE0B2),
    ),
  ).copyWith(
    extensions: <ThemeExtension<dynamic>>[
      MyColorsExtension(
        submitColor: Color(0xFFFFA726),
        onlineColor: Color(0xFFF57C00),
        disabledColor: Color(0x50FFA726),
        offlineColor: Color(0xFFFFE0B2),
        translucentColor: Color(0x50FFA726),
      ),
    ],
  );

  // BLACK & WHITE
  final ThemeData bwLightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: Colors.black,
    scaffoldBackgroundColor: Colors.white,
    canvasColor: Colors.white,
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: Colors.black,
      onPrimary: Colors.white,
      secondary: Colors.grey,
      onSecondary: Colors.black,
      surface: Colors.white,
      onSurface: Colors.black,
      error: Colors.red,
      onError: Colors.white,
      tertiary: Colors.grey[300]!,
      onTertiary: Colors.black,
    ),
    textTheme: TextTheme().apply(
      bodyColor: Colors.black,
      displayColor: Colors.black,
    ),
  ).copyWith(
    extensions: <ThemeExtension<dynamic>>[
      MyColorsExtension(
        submitColor: Colors.black,
        onlineColor: Colors.grey,
        disabledColor: Color(0x50000000),
        offlineColor: Colors.grey[300]!,
        translucentColor: Color(0x50000000),
      ),
    ],
  );

  final ThemeData bwDarkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: Colors.white,
    scaffoldBackgroundColor: Colors.black,
    canvasColor: Colors.black,
    colorScheme: ColorScheme(
      brightness: Brightness.dark,
      primary: Colors.white,
      onPrimary: Colors.black,
      secondary: Colors.grey,
      onSecondary: Colors.white,
      surface: Colors.black,
      onSurface: Colors.white,
      error: Colors.red[400]!,
      onError: Colors.black,
      tertiary: Colors.grey[700]!,
      onTertiary: Colors.white,
    ),
    textTheme: TextTheme().apply(
      bodyColor: Colors.white,
      displayColor: Colors.white,
    ),
  ).copyWith(
    extensions: <ThemeExtension<dynamic>>[
      MyColorsExtension(
        submitColor: Colors.white,
        onlineColor: Colors.grey,
        disabledColor: Color(0x50FFFFFF),
        offlineColor: Colors.grey[700]!,
        translucentColor: Color(0x50FFFFFF),
      ),
    ],
  );
}
