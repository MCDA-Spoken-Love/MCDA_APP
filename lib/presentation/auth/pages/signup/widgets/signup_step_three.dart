import 'package:flutter/material.dart';
import 'package:mcda_app/common/widgets/button/besty_button.dart';
import 'package:mcda_app/common/widgets/containers/custom_container.dart';
import 'package:mcda_app/common/widgets/input/besty_input.dart';
import 'package:mcda_app/core/configs/theme/my_colors_extension.dart';

class SignupStepThree extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController passwordCon;
  final TextEditingController confirmPasswordCon;
  final VoidCallback submit;
  final VoidCallback previousStep;

  const SignupStepThree({
    super.key,
    required this.formKey,
    required this.passwordCon,
    required this.confirmPasswordCon,
    required this.submit,
    required this.previousStep,
  });

  @override
  Widget build(BuildContext context) {
    final MyColorsExtension myColors =
        Theme.of(context).extension<MyColorsExtension>()!;
    final ThemeData colors = Theme.of(context);

    return SizedBox(
      height: MediaQuery.of(context).size.height * .95,
      child: Column(
        children: [
          Spacer(),
          CustomContainer(
            position: 'top',
            child: Column(
              children: [
                BestyInput(
                  controller: passwordCon,
                  label: 'Password',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                  inputType: 'password',
                ),
                SizedBox(height: 20),
                BestyInput(
                  controller: confirmPasswordCon,
                  label: 'Password Confirmation',
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        value != passwordCon.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                  inputType: 'password',
                ),
              ],
            ),
          ),
          CustomContainer(
            position: 'bottom',
            child: Row(
              children: [
                BestyButton(
                  width: MediaQuery.of(context).size.width * .4,
                  onPressed: () {
                    previousStep();
                  },
                  title: 'Previous',
                  titleSize: 14,
                  backgroundColor: Colors.white,
                  titleColor: colors.highlightColor,
                ),
                SizedBox(width: MediaQuery.of(context).size.width * .02),
                BestyButton(
                  width: MediaQuery.of(context).size.width * .4,
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      submit();
                    } else {
                      return;
                    }
                  },
                  title: 'Create Account',
                  titleSize: 10,
                  backgroundColor: myColors.submitColor,
                  titleColor: Colors.white,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
