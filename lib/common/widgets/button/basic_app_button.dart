import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mcda_app/common/button/button_state.dart';
import 'package:mcda_app/common/button/button_state_cubit.dart';

class BasicAppButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  final double? height;
  final double? width;

  const BasicAppButton({
    super.key,
    required this.onPressed,
    required this.title,
    this.height,
    this.width,
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
    return ElevatedButton(
      onPressed: null,
      style: ElevatedButton.styleFrom(
        disabledBackgroundColor: Colors.grey,
        minimumSize: Size(
          width ?? MediaQuery.of(context).size.width * 0.5,
          height ?? 60,
        ),
      ),
      child: CircularProgressIndicator(color: Colors.white),
    );
  }

  Widget _initial(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xff3461FD).withOpacity(0.8),
            offset: const Offset(0, 5),
            blurRadius: 17,
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          minimumSize: Size(
            width ?? MediaQuery.of(context).size.width,
            height ?? 60,
          ),
        ),
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
