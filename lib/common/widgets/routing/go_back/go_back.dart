import 'package:flutter/material.dart';

class GoBack extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onPressed;

  @override
  final Size preferredSize;
  const GoBack({
    super.key,
    required this.title,
    this.onPressed,
    this.preferredSize = const Size.fromHeight(80),
  });

  @override
  State<GoBack> createState() => _GoBackState();
}

class _GoBackState extends State<GoBack> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            widget.onPressed ?? Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back, size: 24),
        ),
        SizedBox(width: 16),
        Text(
          widget.title,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
