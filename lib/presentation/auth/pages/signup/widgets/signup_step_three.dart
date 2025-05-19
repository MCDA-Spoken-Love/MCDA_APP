import 'package:flutter/material.dart';
import 'package:mcda_app/common/widgets/button/besty_button.dart';
import 'package:mcda_app/common/widgets/checkbox/checkbox.dart';
import 'package:mcda_app/common/widgets/containers/custom_container.dart';
import 'package:mcda_app/common/widgets/input/besty_input.dart';
import 'package:mcda_app/core/configs/theme/my_colors_extension.dart';
import 'package:mcda_app/presentation/auth/pages/signup/widgets/privacy_policy.dart';
import 'package:mcda_app/presentation/auth/pages/signup/widgets/terms_and_conditions.dart';

class SignupStepThree extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController passwordCon;
  final TextEditingController confirmPasswordCon;
  final Function(BuildContext) submit;
  final VoidCallback previousStep;
  final void Function(bool?) acceptPrivacyPolicy;
  final void Function(bool?) acceptTermsAndConditions;
  final bool hasAcceptedPrivacyPolicy;
  final bool hasAcceptedTermsAndConditions;

  const SignupStepThree({
    super.key,
    required this.formKey,
    required this.passwordCon,
    required this.confirmPasswordCon,
    required this.submit,
    required this.previousStep,
    required this.acceptPrivacyPolicy,
    required this.acceptTermsAndConditions,
    required this.hasAcceptedPrivacyPolicy,
    required this.hasAcceptedTermsAndConditions,
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
                    if (value.length < 8) {
                      return 'Password must be at least 8 characters';
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
            child: Column(
              children: [
                FormField(
                  validator: (value) {
                    if (!hasAcceptedPrivacyPolicy) {
                      return 'Please accept the terms and conditions';
                    }
                    return null;
                  },
                  builder: (FormFieldState<dynamic> field) {
                    return CustomCheckBox(
                      value: hasAcceptedTermsAndConditions,
                      isError: field.hasError,
                      label: TermsAndConditions(),
                      onChanged: (value) {
                        acceptTermsAndConditions(value);
                      },
                    );
                  },
                ),

                SizedBox(height: 20),
                FormField(
                  validator: (value) {
                    if (!hasAcceptedPrivacyPolicy) {
                      return 'Please accept the privacy policy';
                    }
                    return null;
                  },
                  builder: (FormFieldState<dynamic> field) {
                    return CustomCheckBox(
                      value: hasAcceptedPrivacyPolicy,
                      isError: field.hasError,
                      label: PrivacyPolicy(),
                      onChanged: (value) {
                        acceptPrivacyPolicy(value);
                      },
                    );
                  },
                ),
                SizedBox(height: 20),

                Row(
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
                    submit(context),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
