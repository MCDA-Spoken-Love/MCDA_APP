import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  final double? height;
  final double? width;
  final Color? backgroundColor;
  final Color? titleColor;
  final double? titleSize;
  final bool? disabled;
  final bool? error;
  final bool? isLoading;

  const CustomButton({
    super.key,
    required this.onPressed,
    required this.title,
    this.height,
    this.width,
    this.backgroundColor,
    this.titleColor,
    this.titleSize,
    this.disabled,
    this.error,
    this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading == true) {
      return _loading(context);
    }
    if (error == true) {
      return _error(context);
    }

    return _initial(context);
  }

  Widget _error(BuildContext context) {
    ThemeData themeColors = Theme.of(context);
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        backgroundColor: themeColors.colorScheme.error,
        minimumSize: Size(
          width ?? MediaQuery.of(context).size.width,
          height ?? 60,
        ),
      ),
      child: Text(
        title,
        style: TextStyle(
          color: titleColor ?? themeColors.textTheme.bodyMedium?.color,
          fontSize: titleSize ?? 20,
        ),
      ),
    );
  }

  Widget _loading(BuildContext context) {
    ThemeData themeColors = Theme.of(context);
    return ElevatedButton(
      onPressed: null,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        disabledBackgroundColor: themeColors.disabledColor,
        minimumSize: Size(
          width ?? MediaQuery.of(context).size.width,
          height ?? 60,
        ),
      ),
      child: CircularProgressIndicator(color: Colors.white),
    );
  }

  Widget _initial(BuildContext context) {
    ThemeData themeColors = Theme.of(context);

    return ElevatedButton(
      onPressed: disabled == true ? null : onPressed,
      style: ElevatedButton.styleFrom(
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        backgroundColor: backgroundColor ?? themeColors.colorScheme.primary,
        minimumSize: Size(
          width ?? MediaQuery.of(context).size.width,
          height ?? 60,
        ),
      ),

      child: Text(
        title,
        style: TextStyle(
          color: titleColor ?? themeColors.textTheme.bodyMedium?.color,
          fontSize: titleSize ?? 20,
        ),
      ),
    );
  }
}
