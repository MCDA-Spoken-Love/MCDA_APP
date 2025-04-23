import 'package:flutter/material.dart';

class MyColorsExtension extends ThemeExtension<MyColorsExtension> {
  MyColorsExtension({
    required this.primaryColor,
    required this.secondaryColor,
    required this.backgroundColor,
    required this.accentColor,
    required this.tertiaryColor,
    required this.submitColor,
    required this.cancelColor,
    required this.onlineColor,
    required this.disabledColor,
    required this.errorColor,
    required this.offlineColor,
    required this.translucentColor,
  });

  final Color? primaryColor;
  final Color? secondaryColor;
  final Color? backgroundColor;
  final Color? accentColor;
  final Color? tertiaryColor;
  final Color? submitColor;
  final Color? cancelColor;
  final Color? onlineColor;
  final Color? disabledColor;
  final Color? offlineColor;
  final Color? errorColor;
  final Color? translucentColor;

  @override
  ThemeExtension<MyColorsExtension> copyWith() {
    return MyColorsExtension(
      primaryColor: primaryColor,
      secondaryColor: secondaryColor,
      backgroundColor: backgroundColor,
      accentColor: accentColor,
      tertiaryColor: tertiaryColor,
      submitColor: submitColor,
      cancelColor: cancelColor,
      onlineColor: onlineColor,
      offlineColor: offlineColor,
      disabledColor: disabledColor,
      errorColor: errorColor,
      translucentColor: translucentColor,
    );
  }

  @override
  ThemeExtension<MyColorsExtension> lerp(
    covariant ThemeExtension<MyColorsExtension>? other,
    double t,
  ) {
    if (other is! MyColorsExtension) {
      return this;
    }

    return MyColorsExtension(
      primaryColor: Color.lerp(primaryColor, other.primaryColor, t)!,
      secondaryColor: Color.lerp(secondaryColor, other.secondaryColor, t)!,
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t)!,
      accentColor: Color.lerp(accentColor, other.accentColor, t)!,
      tertiaryColor: Color.lerp(tertiaryColor, other.tertiaryColor, t)!,
      submitColor: Color.lerp(submitColor, other.submitColor, t)!,
      cancelColor: Color.lerp(cancelColor, other.cancelColor, t)!,
      onlineColor: Color.lerp(onlineColor, other.onlineColor, t)!,
      disabledColor: Color.lerp(disabledColor, other.disabledColor, t)!,
      offlineColor: Color.lerp(offlineColor, other.offlineColor, t)!,
      errorColor: Color.lerp(errorColor, other.errorColor, t)!,
      translucentColor:
          Color.lerp(translucentColor, other.translucentColor, t)!,
    );
  }
}
