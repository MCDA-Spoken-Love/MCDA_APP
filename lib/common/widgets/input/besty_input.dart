import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mcda_app/common/blocs/valid_input/valid_input_state.dart';
import 'package:mcda_app/common/blocs/valid_input/valid_input_state_cubit.dart';
import 'package:mcda_app/common/widgets/text/besty_title.dart';

class BestyInput extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final String? inputType;
  final FormFieldValidator<String>? validator;
  final Widget? suffixIcon;
  final void Function(dynamic)? onChanged;
  final void onTapOutside;

  const BestyInput({
    super.key,
    required this.controller,
    required this.label,
    this.inputType = 'text',
    this.validator,
    this.suffixIcon,
    this.onChanged,
    this.onTapOutside,
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

  Widget _loading(BuildContext context) {
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
          onChanged: widget.onChanged,
          enabled: false,
          onTapOutside: (event) {
            widget.onTapOutside;
          },
          validator: widget.validator,
          obscureText: _obscureText && widget.inputType == 'password',
          controller: widget.controller,
          decoration: _decorator(
            context,
            CircularProgressIndicator(),
            themeColors.disabledColor,
          ),
        ),
      ],
    );
  }

  Widget _initial(BuildContext context) {
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
          onChanged: widget.onChanged,
          onTapOutside: (event) {
            widget.onTapOutside;
          },
          validator: widget.validator,
          obscureText: _obscureText && widget.inputType == 'password',
          controller: widget.controller,
          decoration: _decorator(
            context,
            null,
            themeColors.colorScheme.tertiary,
          ),
        ),
      ],
    );
  }

  InputDecoration _decorator(
    BuildContext context,
    Widget? suffixIcon,
    Color? fillColor,
  ) {
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
    return BlocBuilder<ValidInputStateCubit, ValidInputState>(
      builder: (context, state) {
        if (state is ValidInputLoadingState) {
          return _loading(context);
        }
        return _initial(context);
      },
    );
  }
}
