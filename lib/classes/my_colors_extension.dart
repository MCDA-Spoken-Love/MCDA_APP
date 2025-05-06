import 'package:flutter/material.dart';

class MyColorsExtension extends ThemeExtension<MyColorsExtension> {
  MyColorsExtension({
    required this.submitColor,
    required this.onlineColor,
    required this.disabledColor,
    required this.offlineColor,
    required this.translucentColor,
  });

  final Color? submitColor;
  final Color? onlineColor;
  final Color? disabledColor;
  final Color? offlineColor;
  final Color? translucentColor;

  @override
  ThemeExtension<MyColorsExtension> copyWith() {
    return MyColorsExtension(
      submitColor: submitColor,
      onlineColor: onlineColor,
      offlineColor: offlineColor,
      disabledColor: disabledColor,
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
      submitColor: Color.lerp(submitColor, other.submitColor, t)!,
      onlineColor: Color.lerp(onlineColor, other.onlineColor, t)!,
      disabledColor: Color.lerp(disabledColor, other.disabledColor, t)!,
      offlineColor: Color.lerp(offlineColor, other.offlineColor, t)!,
      translucentColor:
          Color.lerp(translucentColor, other.translucentColor, t)!,
    );
  }
}
