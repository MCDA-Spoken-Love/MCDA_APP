import 'package:flutter/material.dart';

class CustomCheckBox extends StatelessWidget {
  final bool value;
  final bool isError;
  final void Function(bool?)? onChanged;
  final Widget label;

  const CustomCheckBox({
    super.key,
    required this.value,
    required this.isError,
    this.onChanged,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 24.0,
          width: 24.0,
          child: Checkbox(onChanged: onChanged, value: value, isError: isError),
        ),
        SizedBox(width: 8.0),
        label,
      ],
    );
  }
}
