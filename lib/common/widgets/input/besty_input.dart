import 'package:flutter/material.dart';

import '../text/besty_title.dart';

class BestyInput extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final String? inputType;
  final FormFieldValidator<String>? validator;
  final Widget? suffixIcon;

  const BestyInput({
    super.key,
    required this.controller,
    required this.label,
    this.inputType = 'text',
    this.validator,
    this.suffixIcon,
  });

  @override
  State<BestyInput> createState() => _BestyInputState();
}

class _BestyInputState extends State<BestyInput> {
  bool _obscureText = true;

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeColors = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BestyTitle(
          title: widget.label,
          textAlign: TextAlign.start,
          color: Colors.white,
          fontSize: 20,
        ),
        SizedBox(height: 8),
        TextFormField(
          validator: widget.validator,
          obscureText: _obscureText && widget.inputType == 'password',
          controller: widget.controller,
          decoration: InputDecoration(
            filled: true,
            fillColor: themeColors.colorScheme.tertiary,
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12.0)),
              borderSide: BorderSide(
                color: themeColors.colorScheme.error,
                width: 3,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12.0)),
              borderSide: BorderSide(color: themeColors.hintColor, width: 3),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12.0)),
              borderSide: BorderSide(color: themeColors.hintColor, width: 3),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(12.0)),
              borderSide: BorderSide(color: themeColors.hintColor, width: 3),
            ),
            floatingLabelBehavior: FloatingLabelBehavior.never,
            suffixIcon:
                widget.inputType == 'password'
                    ? Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
                      child: GestureDetector(
                        onTap: _toggle,
                        child: Icon(
                          _obscureText
                              ? Icons.visibility_rounded
                              : Icons.visibility_off_rounded,
                          size: 24,
                        ),
                      ),
                    )
                    : widget.suffixIcon,
          ),
        ),
      ],
    );
  }
}
