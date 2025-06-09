import 'package:flutter/material.dart';
import 'package:mcda_app/common/widgets/text/besty_title.dart';

class BestyInput extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final String? inputType;
  final FormFieldValidator<String>? validator;
  final Widget? suffixIcon;
  final void Function(dynamic)? onChanged;
  final void onTapOutside;
  final bool? error;
  final bool? isLoading;
  final String? errorMessage;

  const BestyInput({
    super.key,
    required this.controller,
    required this.label,
    this.inputType = 'text',
    this.validator,
    this.suffixIcon,
    this.onChanged,
    this.onTapOutside,
    this.error,
    this.isLoading,
    this.errorMessage,
  }) : assert(
         inputType == 'text' ||
             inputType == 'email' ||
             inputType == 'password' ||
             inputType == 'number',
         'inputType must be text, email, password or number',
       );

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

  Widget _title() {
    ThemeData themeColors = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BestyTitle(
          title: widget.label,
          textAlign: TextAlign.start,
          color: themeColors.canvasColor,
          fontSize: 20,
        ),
        SizedBox(height: 8),
      ],
    );
  }

  Widget _loading() {
    ThemeData themeColors = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _title(),
        TextFormField(
          style: TextStyle(color: themeColors.colorScheme.error),
          onChanged: widget.onChanged,
          enabled: false,
          onTapOutside: (event) {
            widget.onTapOutside;
          },
          validator: widget.validator,
          obscureText: _obscureText && widget.inputType == 'password',
          controller: widget.controller,
          decoration: _decorator(
            CircularProgressIndicator(),
            themeColors.colorScheme.tertiary,
          ),
        ),
      ],
    );
  }

  Widget _error() {
    ThemeData themeColors = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _title(),

        TextFormField(
          style: TextStyle(color: themeColors.colorScheme.error),
          forceErrorText: widget.errorMessage,
          onChanged: widget.onChanged,
          onTapOutside: (event) {
            widget.onTapOutside;
          },
          validator: widget.validator,
          obscureText: _obscureText && widget.inputType == 'password',
          controller: widget.controller,
          decoration: _decorator(
            Icon(Icons.error, color: themeColors.colorScheme.error),
            themeColors.colorScheme.tertiary,
          ),
        ),
      ],
    );
  }

  Widget _initial() {
    ThemeData themeColors = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _title(),
        TextFormField(
          style: TextStyle(color: themeColors.colorScheme.primary),

          onChanged: widget.onChanged,
          onTapOutside: (event) {
            widget.onTapOutside;
          },
          validator: widget.validator,
          obscureText: _obscureText && widget.inputType == 'password',
          controller: widget.controller,
          decoration: _decorator(null, themeColors.colorScheme.tertiary),
        ),
      ],
    );
  }

  InputDecoration _decorator(Widget? suffixIcon, Color? fillColor) {
    ThemeData themeColors = Theme.of(context);

    return InputDecoration(
      filled: true,
      fillColor: fillColor ?? themeColors.colorScheme.tertiary,
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
        borderSide: BorderSide(color: themeColors.colorScheme.error, width: 3),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
        borderSide: BorderSide(color: themeColors.disabledColor, width: 3),
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
          suffixIcon != null
              ? UnconstrainedBox(child: suffixIcon)
              : widget.inputType == 'password'
              ? Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
                child: GestureDetector(
                  onTap: _toggle,
                  child: Icon(
                    color: themeColors.colorScheme.primary,
                    _obscureText
                        ? Icons.visibility_rounded
                        : Icons.visibility_off_rounded,
                    size: 24,
                  ),
                ),
              )
              : widget.suffixIcon,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isLoading == true) {
      return _loading();
    }
    if (widget.error == true) {
      return _error();
    }

    return _initial();
  }
}
