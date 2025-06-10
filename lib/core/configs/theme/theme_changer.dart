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
        ).redLightTheme;
      case 'purple':
        return AppTheme(
          darkDynamic: darkDynamic,
          lightDynamic: lightDynamic,
        ).purpleLightTheme;
      case 'green':
        return AppTheme(
          darkDynamic: darkDynamic,
          lightDynamic: lightDynamic,
        ).greenLightTheme;
      case 'orange':
        return AppTheme(
          darkDynamic: darkDynamic,
          lightDynamic: lightDynamic,
        ).orangeLightTheme;
      case 'yellow':
        return AppTheme(
          darkDynamic: darkDynamic,
          lightDynamic: lightDynamic,
        ).yellowLightTheme;
      case 'bw':
        return AppTheme(
          darkDynamic: darkDynamic,
          lightDynamic: lightDynamic,
        ).bwLightTheme;
      case 'blue':
        return AppTheme(
          darkDynamic: darkDynamic,
          lightDynamic: lightDynamic,
        ).blueLightTheme;
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
      case 'ios':
        return AppTheme(
          darkDynamic: darkDynamic,
          lightDynamic: lightDynamic,
        ).iosLightTheme;
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
        ).redDarkTheme;
      case 'purple':
        return AppTheme(
          darkDynamic: darkDynamic,
          lightDynamic: lightDynamic,
        ).purpleDarkTheme;
      case 'green':
        return AppTheme(
          darkDynamic: darkDynamic,
          lightDynamic: lightDynamic,
        ).greenDarkTheme;
      case 'orange':
        return AppTheme(
          darkDynamic: darkDynamic,
          lightDynamic: lightDynamic,
        ).orangeDarkTheme;
      case 'yellow':
        return AppTheme(
          darkDynamic: darkDynamic,
          lightDynamic: lightDynamic,
        ).yellowDarkTheme;
      case 'bw':
        return AppTheme(
          darkDynamic: darkDynamic,
          lightDynamic: lightDynamic,
        ).bwDarkTheme;
      case 'blue':
        return AppTheme(
          darkDynamic: darkDynamic,
          lightDynamic: lightDynamic,
        ).blueDarkTheme;
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
      case 'ios':
        return AppTheme(
          darkDynamic: darkDynamic,
          lightDynamic: lightDynamic,
        ).iosDarkTheme;
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
