import 'package:flutter/material.dart';

import 'my_colors_extension.dart';

Color saturate(Color color, double amount) {
  final hsl = HSLColor.fromColor(color);
  final saturated = hsl.withSaturation(
    (hsl.saturation * (1 + amount)).clamp(0.0, 1.0),
  );
  return saturated.toColor();
}

// Helper for more colorful backgrounds in dark themes
Color colorfulDark(Color base, Color accent, {double blend = 0.15}) {
  return Color.lerp(base, accent, blend) ?? base;
}

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
    canvasColor: Color(0xFF1f1c27),
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
    highlightColor:
        lightDynamic?.primary.withOpacity(0.7) ?? Colors.white, // brighter
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
    highlightColor:
        darkDynamic?.primary.withOpacity(0.7) ?? Colors.white, // brighter
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

  // iOS
  ThemeData iosLightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: Color(0xFF007AFF),
    scaffoldBackgroundColor: Color(0xFFF9F9F9),
    canvasColor: Color(0xFFF9F9F9),
    highlightColor: Color(0xFF60AFFF),
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xFF007AFF),
      onPrimary: Colors.white,
      secondary: Color(0xFF5856D6),
      onSecondary: Colors.white,
      surface: Color(0xFFFFFFFF),
      onSurface: Color(0xFF1C1C1E),
      error: Color(0xFFFF3B30),
      onError: Colors.white,
      tertiary: Color(0xFF34C759),
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
    primaryColor: Color(0xFF0A84FF),
    scaffoldBackgroundColor: Color(0xFF000000),
    canvasColor: Color(0xFF000000),
    highlightColor: Color(0xFF5CADFF),
    colorScheme: ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xFF0A84FF),
      onPrimary: Colors.white,
      secondary: Color(0xFF5E5CE6),
      onSecondary: Colors.white,
      surface: Color(0xFF1C1C1E),
      onSurface: Color(0xFFF2F2F7),
      error: Color(0xFFFF453A),
      onError: Colors.white,
      tertiary: Color(0xFF30D158),
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

  // Blue
  final ThemeData blueLightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: Color(0xFF1976D2),
    scaffoldBackgroundColor: Color(0xFFF5F8FD),
    canvasColor: Color(0xFFF5F8FD),
    highlightColor: Color(0xFF63A4FF),
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xFF1976D2),
      onPrimary: Colors.white,
      secondary: Color(0xFF42A5F5),
      onSecondary: Colors.white,
      surface: Color(0xFFFFFFFF),
      onSurface: Color(0xFF0D1333),
      error: Color(0xFFD32F2F),
      onError: Colors.white,
      tertiary: Color(0xFF90CAF9),
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
    primaryColor: Color(0xFF2196F3),
    scaffoldBackgroundColor: colorfulDark(Color(0xFF121A2B), Color(0xFF2196F3)),
    canvasColor: colorfulDark(Color(0xFF121A2B), Color(0xFF2196F3)),
    highlightColor: Color(0xFF6EC6FF),
    colorScheme: ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xFF2196F3),
      onPrimary: Colors.white,
      secondary: Color(0xFF64B5F6),
      onSecondary: Colors.white,
      surface: Color(0xFF1A237E),
      onSurface: Color(0xFFE3F2FD),
      error: Color(0xFFEF5350),
      onError: Colors.white,
      tertiary: Color(0xFF90CAF9),
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

  // Green
  final ThemeData greenLightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: Color(0xFF43A047),
    scaffoldBackgroundColor: Color(0xFFF1F8E9),
    canvasColor: Color(0xFFF1F8E9),
    highlightColor: Color(0xFF76D275),
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xFF43A047),
      onPrimary: Colors.white,
      secondary: Color(0xFF66BB6A),
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
    scaffoldBackgroundColor: colorfulDark(Color(0xFF263238), Color(0xFF66BB6A)),
    canvasColor: colorfulDark(Color(0xFF263238), Color(0xFF66BB6A)),
    highlightColor: Color(0xFF98EE99),
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

  // Red
  final ThemeData redLightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: Color(0xFFD32F2F),
    scaffoldBackgroundColor: Color(0xFFFFEBEE),
    canvasColor: Color(0xFFFFEBEE),
    highlightColor: Color(0xFFFF6659),
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
    scaffoldBackgroundColor: colorfulDark(Color(0xFF212121), Color(0xFFEF5350)),
    canvasColor: colorfulDark(Color(0xFF212121), Color(0xFFEF5350)),
    highlightColor: Color(0xFFFF867C),
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

  // Yellow
  final ThemeData yellowLightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: Color(0xFFFFB300),
    scaffoldBackgroundColor: Color(0xFFFFFDE7),
    canvasColor: Color(0xFFFFFDE7),
    highlightColor: Color(0xFFFFF176),
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
    scaffoldBackgroundColor: colorfulDark(Color(0xFF212121), Color(0xFFFFF176)),
    canvasColor: colorfulDark(Color(0xFF212121), Color(0xFFFFF176)),
    highlightColor: Color(0xFFFFFF8D),
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

  // Purple
  final ThemeData purpleLightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: Color(0xFF8E24AA),
    scaffoldBackgroundColor: Color(0xFFF3E5F5),
    canvasColor: Color(0xFFF3E5F5),
    highlightColor: Color(0xFFCE93D8),
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
    scaffoldBackgroundColor: colorfulDark(Color(0xFF212121), Color(0xFFBA68C8)),
    canvasColor: colorfulDark(Color(0xFF212121), Color(0xFFBA68C8)),
    highlightColor: Color(0xFFE1BEE7),
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

  // Orange
  final ThemeData orangeLightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: Color(0xFFF57C00),
    scaffoldBackgroundColor: Color(0xFFFFF3E0),
    canvasColor: Color(0xFFFFF3E0),
    highlightColor: Color(0xFFFFB74D),
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
    scaffoldBackgroundColor: colorfulDark(Color(0xFF212121), Color(0xFFFFA726)),
    canvasColor: colorfulDark(Color(0xFF212121), Color(0xFFFFA726)),
    highlightColor: Color(0xFFFFCC80),
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

  // Black & White
  final ThemeData bwLightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: Colors.black,
    scaffoldBackgroundColor: Colors.white,
    canvasColor: Colors.white,
    highlightColor: Colors.grey[400],
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
    scaffoldBackgroundColor: colorfulDark(Colors.black, Colors.white),
    canvasColor: colorfulDark(Colors.black, Colors.white),
    highlightColor: Colors.grey[100],
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
