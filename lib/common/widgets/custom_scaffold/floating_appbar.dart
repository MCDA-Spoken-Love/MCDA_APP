import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mcda_app/core/configs/theme/my_colors_extension.dart';

class FloatingAppBar extends StatelessWidget {
  final Widget child;
  const FloatingAppBar.withChild({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    MyColorsExtension myColors = theme.extension<MyColorsExtension>()!;

    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: Material(
          borderRadius: BorderRadius.circular(12),
          color: myColors.extensionPrimary,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: child,
          ),
        ),
      ),
    );
  }
}
