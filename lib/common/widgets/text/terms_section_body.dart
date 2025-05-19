import 'package:flutter/material.dart';

class SectionBody extends StatelessWidget {
  final String text;
  const SectionBody(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(text, style: const TextStyle(fontSize: 16));
  }
}
