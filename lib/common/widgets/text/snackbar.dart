import 'package:flutter/material.dart';
import 'package:mcda_app/core/configs/theme/my_colors_extension.dart';

class GlobalSnackBar {
  final String message;
  final String status;
  const GlobalSnackBar(
    BuildContext context,
    String errorMessage, {
    required this.message,
    required this.status,
  }) : assert(
         status == 'success' || status == 'warning' || status == 'error',
         'status must be success, warning or error',
       );

  static show(BuildContext context, String message, {required String status}) {
    ThemeData colors = Theme.of(context);
    MyColorsExtension myColorsExtension =
        colors.extension<MyColorsExtension>()!;

    Color? bgColor() {
      switch (status) {
        case 'success':
          return myColorsExtension.submitColor;
        case 'error':
          return colors.colorScheme.error;
        case 'warning':
          return Colors.amberAccent;
        default:
          return Colors.black;
      }
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        elevation: 100.0,
        behavior: SnackBarBehavior.floating,
        dismissDirection: DismissDirection.up,

        content: Text(message),
        backgroundColor: bgColor(),
        duration: Duration(seconds: 3),
        margin: EdgeInsets.only(bottom: 20, top: 20, left: 20, right: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16.0)),
        ),

        //backgroundColor: Colors.redAccent,
      ),
    );
  }
}
