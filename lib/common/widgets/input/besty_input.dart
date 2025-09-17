import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mcda_app/common/widgets/text/besty_title.dart';
import 'package:mcda_app/core/configs/theme/my_colors_extension.dart';

class BestyInput extends StatefulWidget {
  final TextEditingController? controller;
  final String label;
  final String? inputType;
  final FormFieldValidator<String>? validator;
  final Widget? suffixIcon;
  final void Function(dynamic)? onChanged;
  final void onTapOutside;
  final bool? error;
  final bool? isLoading;
  final String? errorMessage;
  final String? copyToastMessage;
  final int? maxLength; // NEW

  const BestyInput({
    super.key,
    this.controller,
    required this.label,
    this.inputType = 'text',
    this.validator,
    this.suffixIcon,
    this.onChanged,
    this.onTapOutside,
    this.error,
    this.isLoading,
    this.errorMessage,
    this.copyToastMessage,
    this.maxLength, // NEW
  }) : assert(
         inputType == 'text' ||
             inputType == 'email' ||
             inputType == 'password' ||
             inputType == 'number' ||
             inputType == 'copy',
         'inputType must be text, email, password, number or copy',
       );

  @override
  State<BestyInput> createState() => _BestyInputState();
}

class _BestyInputState extends State<BestyInput> {
  bool _obscureText = true;
  late final TextEditingController _effectiveController;
  late final bool _ownsController;
  String? _copyFeedback;

  @override
  void initState() {
    super.initState();
    _ownsController = widget.controller == null;
    _effectiveController = widget.controller ?? TextEditingController();
  }

  @override
  void dispose() {
    if (_ownsController) {
      _effectiveController.dispose();
    }
    super.dispose();
  }

  Future<void> _handleCopy() async {
    final text = _effectiveController.text;
    if (text.isEmpty) return;
    await Clipboard.setData(ClipboardData(text: text));
    setState(() {
      _copyFeedback = widget.copyToastMessage ?? 'Copied';
    });
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _copyFeedback = null;
        });
      }
    });
  }

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
          fontSize: 16,
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
          controller: _effectiveController,
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
          controller: _effectiveController,
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
    final bool isCopy = widget.inputType == 'copy';
    final suffix = _buildSuffix(themeColors, isCopy);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _title(),
        TextFormField(
          style: TextStyle(color: themeColors.colorScheme.primary),
          onChanged: isCopy ? null : widget.onChanged,
          readOnly: isCopy, // IMPORTANT for copy-only mode
          enableInteractiveSelection: true,
          onTapOutside: (event) {
            widget.onTapOutside;
          },
          maxLength: widget.maxLength,
          maxLengthEnforcement: MaxLengthEnforcement.enforced,
          validator: widget.validator,
          obscureText: _obscureText && widget.inputType == 'password',
          controller: _effectiveController,
          decoration: _decorator(suffix, themeColors.colorScheme.tertiary),
        ),
      ],
    );
  }

  Widget? _buildSuffix(ThemeData themeColors, bool isCopy) {
    ThemeData themeColors = Theme.of(context);

    if (widget.suffixIcon != null && !isCopy) return widget.suffixIcon;

    if (widget.inputType == 'password') {
      return Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
        child: GestureDetector(
          onTap: _toggle,
          child: Icon(
            _obscureText
                ? Icons.visibility_rounded
                : Icons.visibility_off_rounded,
            color: themeColors.colorScheme.primary,
            size: 24,
          ),
        ),
      );
    }

    if (isCopy) {
      return IconButton(
        tooltip: 'Copy',
        splashRadius: 20,
        icon: Icon(
          _copyFeedback == null ? Icons.copy_rounded : Icons.check_rounded,
          color:
              _copyFeedback == null
                  ? themeColors.colorScheme.primary
                  : themeColors.extension<MyColorsExtension>()?.submitColor,
        ),
        onPressed: _handleCopy,
      );
    }

    return widget.suffixIcon;
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
