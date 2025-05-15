import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../core/configs/theme/my_colors_extension.dart';

class CustomContainer extends StatelessWidget {
  final Widget child;
  final String position;

  const CustomContainer({
    super.key,
    required this.child,
    required this.position,
  }) : assert(
         position == 'top' || position == 'middle' || position == 'bottom',
         'position must be top, bottom or middle',
       );

  BorderRadius handleBorderRadius() {
    switch (position) {
      case 'top':
        return const BorderRadius.only(
          topLeft: Radius.circular(24.0),
          topRight: Radius.circular(24.0),
          bottomLeft: Radius.circular(6.0),
          bottomRight: Radius.circular(6.0),
        );
      case 'bottom':
        return const BorderRadius.only(
          topLeft: Radius.circular(6.0),
          topRight: Radius.circular(6.0),
          bottomLeft: Radius.circular(24.0),
          bottomRight: Radius.circular(24.0),
        );
      case 'middle':
        return BorderRadius.all(Radius.circular(6.0));
      case 'unique':
      default:
        return BorderRadius.all(Radius.circular(24.0));
    }
  }

  @override
  Widget build(BuildContext context) {
    final MyColorsExtension myColors =
        Theme.of(context).extension<MyColorsExtension>()!;

    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.only(bottom: 2),
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: myColors.translucentColor,
            borderRadius: handleBorderRadius(),
          ),
          child: child,
        ),
      ),
    );
  }
}
