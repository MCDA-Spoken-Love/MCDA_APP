import 'package:flutter/material.dart';
import 'package:mcda_app/classes/app_constants.dart';

import '../provider/theme.dart';

ThemeData themeChanger(ThemeNotifier themeNotifier) {
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
      default:
        return AppConstants().mainDarkTheme;
    }
  }

  return AppConstants().mainLightTheme;
}