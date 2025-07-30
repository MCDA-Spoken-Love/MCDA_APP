import 'package:flutter/material.dart';
import 'package:mcda_app/common/utils/validations.dart';
import 'package:mcda_app/presentation/auth/pages/signin.dart';

import '../../../../../common/widgets/button/besty_button.dart';
import '../../../../../common/widgets/containers/custom_container.dart';
import '../../../../../common/widgets/input/besty_input.dart';
import '../../../../../common/widgets/text/besty_title.dart';
import '../../../../../core/configs/theme/my_colors_extension.dart';

class SignupStepOne extends StatelessWidget {
  final VoidCallback nextStep;
  final GlobalKey<FormState> formKey;
  final TextEditingController firstNameCon;
  final TextEditingController lastNameCon;
  const SignupStepOne({
    super.key,
    required this.nextStep,
    required this.formKey,
    required this.firstNameCon,
    required this.lastNameCon,
  });

  Widget _signupWelcome(BuildContext context) {
    ThemeData colors = Theme.of(context);

    return Column(
      children: [
        CustomContainer(
          position: 'top',
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  BestyTitle(
                    color: Colors.white,
                    fontSize: 14,
                    title: 'Welcome to',
                  ),
                  RichText(
                    text: TextSpan(
                      text: ' M',
                      style: TextStyle(
                        fontSize: 18,
                        color: colors.hintColor,
                        fontFamily: 'BestyBeige',
                      ),
                      children: const <TextSpan>[
                        TextSpan(
                          text: 'ore',
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'BestyBeige',
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      text: ' C',
                      style: TextStyle(
                        fontSize: 18,
                        color: colors.hintColor,
                        fontFamily: 'BestyBeige',
                      ),
                      children: const <TextSpan>[
                        TextSpan(
                          text: 'are',
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'BestyBeige',
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  BestyTitle(color: Colors.white, fontSize: 14, title: ' and'),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      text: 'D',
                      style: TextStyle(
                        fontSize: 18,
                        color: colors.hintColor,
                        fontFamily: 'BestyBeige',
                      ),
                      children: const <TextSpan>[
                        TextSpan(
                          text: 'isplays',
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'BestyBeige',
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  BestyTitle(color: Colors.white, fontSize: 14, title: ' of'),
                  RichText(
                    text: TextSpan(
                      text: ' A',
                      style: TextStyle(
                        fontSize: 18,
                        color: colors.hintColor,
                        fontFamily: 'BestyBeige',
                      ),
                      children: const <TextSpan>[
                        TextSpan(
                          text: 'ffection',
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'BestyBeige',
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              BestyTitle(
                textAlign: TextAlign.justify,
                color: Colors.white,
                fontSize: 14,
                title:
                    'This app was built with the intent of easing the conveying of one the 5 types of love: Words of afection.',
              ),
              const SizedBox(height: 20),
              BestyTitle(
                textAlign: TextAlign.justify,
                color: Colors.white,
                fontSize: 14,
                title:
                    'It was made with love and I hope you and your partner enjoy using it as much as i did enjoy creating it.',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _signupStart(BuildContext context) {
    final MyColorsExtension myColors =
        Theme.of(context).extension<MyColorsExtension>()!;
    final ThemeData colors = Theme.of(context);

    return CustomContainer(
      position: 'bottom',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BestyTitle(
            fontSize: 14,
            color: Colors.white,
            title: 'Let\'s start, shall we?',
          ),
          SizedBox(height: 20),
          BestyInput(
            controller: firstNameCon,
            label: 'Your first name',
            validator: (value) {
              if (value == null ||
                  value.isEmpty ||
                  value.length <= 3 ||
                  value.isValidFullName() == false) {
                return 'Please enter a valid first name';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          BestyInput(
            controller: lastNameCon,
            label: 'Your last name',
            validator: (value) {
              if (value == null ||
                  value.isEmpty ||
                  value.length <= 3 ||
                  value.isValidFullName() == false) {
                return 'Please enter a valid  last name';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: BestyButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SigninPage()),
                    );
                  },
                  title: 'Sign in,',
                  titleSize: 10,
                  backgroundColor: Colors.white,
                  titleColor: colors.highlightColor,
                ),
              ),
              SizedBox(width: MediaQuery.of(context).size.width * .02),
              Expanded(
                child: BestyButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      nextStep();
                    } else {
                      return;
                    }
                  },
                  title: 'Next',
                  titleSize: 14,
                  backgroundColor: myColors.submitColor,
                  titleColor: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * .95,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [Spacer(), _signupWelcome(context), _signupStart(context)],
      ),
    );
  }
}
