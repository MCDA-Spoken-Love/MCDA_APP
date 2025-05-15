import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mcda_app/common/blocs/button/button_state.dart';
import 'package:mcda_app/common/blocs/button/button_state_cubit.dart';
import 'package:mcda_app/common/widgets/text/besty_title.dart';

class BestyButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  final double? height;
  final double? width;
  final Color? backgroundColor;
  final Color? titleColor;
  final double? titleSize;

  const BestyButton({
    super.key,
    required this.onPressed,
    required this.title,
    this.height,
    this.width,
    this.backgroundColor,
    this.titleColor,
    this.titleSize,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ButtonStateCubit, ButtonState>(
      builder: (context, state) {
        if (state is ButtonLoadingState) {
          return _loading(context);
        }
        return _initial(context);
      },
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
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        backgroundColor: backgroundColor ?? themeColors.highlightColor,
        minimumSize: Size(
          width ?? MediaQuery.of(context).size.width,
          height ?? 60,
        ),
      ),
      child: BestyTitle(
        title: title,
        color: titleColor ?? Colors.white,
        fontSize: titleSize ?? 20,
      ),
    );
  }
}
