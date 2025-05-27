import 'package:flutter/material.dart';
import 'package:mcda_app/core/configs/theme/app_theme.dart';

import '../../provider/theme.dart';

ThemeData? themeChanger(
  BuildContext context,
  ThemeNotifier themeNotifier,
  ColorScheme? lightDynamic,
  ColorScheme? darkDynamic,
) {
  final theme = themeNotifier.theme;
  final scheme = themeNotifier.colorScheme;
  var brightness = MediaQuery.platformBrightnessOf(context).name;

  ThemeData lightSwitcher() {
    switch (scheme) {
      case 'red':
        return AppTheme(
          darkDynamic: darkDynamic,
          lightDynamic: lightDynamic,
        ).mainLightTheme;
      case 'blue':
        return AppTheme(
          darkDynamic: darkDynamic,
          lightDynamic: lightDynamic,
        ).mainLightTheme;
      case 'main':
        return AppTheme(
          darkDynamic: darkDynamic,
          lightDynamic: lightDynamic,
        ).mainLightTheme;
      case 'dynamic':
        return AppTheme(
          darkDynamic: darkDynamic,
          lightDynamic: lightDynamic,
        ).dynamicLight;
      default:
        return AppTheme(
          darkDynamic: darkDynamic,
          lightDynamic: lightDynamic,
        ).mainLightTheme;
    }
  }

  ThemeData darkSwitcher() {
    switch (scheme) {
      case 'red':
        return AppTheme(
          darkDynamic: darkDynamic,
          lightDynamic: lightDynamic,
        ).mainDarkTheme;
      case 'blue':
        return AppTheme(
          darkDynamic: darkDynamic,
          lightDynamic: lightDynamic,
        ).mainDarkTheme;
      case 'main':
        return AppTheme(
          darkDynamic: darkDynamic,
          lightDynamic: lightDynamic,
        ).mainDarkTheme;
      case 'dynamic':
        return AppTheme(
          darkDynamic: darkDynamic,
          lightDynamic: lightDynamic,
        ).dynamicDark;
      default:
        return AppTheme(
          darkDynamic: darkDynamic,
          lightDynamic: lightDynamic,
        ).mainDarkTheme;
    }
  }

  if (theme == 'light') {
    return lightSwitcher();
  } else if (theme == 'dark') {
    return darkSwitcher();
  } else if (theme == 'system') {
    if (brightness == 'dark') {
      return darkSwitcher();
    }
    if (brightness == 'light') {
      return lightSwitcher();
    }
  }

  return AppTheme(
    darkDynamic: darkDynamic,
    lightDynamic: lightDynamic,
  ).mainLightTheme;
}
