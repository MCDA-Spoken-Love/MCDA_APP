import 'package:flutter/material.dart';

class BestyTitle extends StatelessWidget {
  final String title;
  final Color? color;
  final double? fontSize;
  final TextAlign? textAlign;

  const BestyTitle({
    super.key,
    required this.title,
    this.color,
    this.fontSize = 24,
    this.textAlign = TextAlign.center,
  });

  @override
  Widget build(BuildContext context) {
    Color defaultColor = Theme.of(context).colorScheme.tertiary;
    return Text(
      title,
      textAlign: textAlign,
      style: TextStyle(
        fontFamily: 'BestyBeige',
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
        color: color ?? defaultColor,
      ),
    );
  }
}
