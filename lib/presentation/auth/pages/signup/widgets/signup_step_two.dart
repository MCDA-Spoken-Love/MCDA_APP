import 'package:flutter/material.dart';

class SignupStepTwo extends StatelessWidget {
  final TextEditingController emailCon;
  final TextEditingController passwordCon;
  final TextEditingController confirmPasswordCon;
  final TextEditingController usernameCon;
  final VoidCallback callback;
  const SignupStepTwo({
    super.key,
    required this.emailCon,
    required this.passwordCon,
    required this.confirmPasswordCon,
    required this.usernameCon,
    required this.callback,
  });

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
