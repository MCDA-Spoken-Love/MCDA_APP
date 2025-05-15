import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mcda_app/common/blocs/valid_input/valid_input_state_cubit.dart';
import 'package:mcda_app/common/utils/constants.dart';
import 'package:mcda_app/common/utils/debounce.dart';
import 'package:mcda_app/common/utils/is_valid_email.dart';
import 'package:mcda_app/common/widgets/button/besty_button.dart';
import 'package:mcda_app/common/widgets/containers/custom_container.dart';
import 'package:mcda_app/common/widgets/dropdown/besty_dropdown.dart';
import 'package:mcda_app/common/widgets/input/besty_input.dart';
import 'package:mcda_app/common/widgets/text/besty_title.dart';
import 'package:mcda_app/core/configs/theme/my_colors_extension.dart';
import 'package:mcda_app/data/models/get_user_by_filter_params.dart';
import 'package:mcda_app/domain/usecases/get_user_by_filter.dart';

class SignupStepTwo extends StatefulWidget {
  final TextEditingController emailCon;
  final TextEditingController passwordCon;
  final TextEditingController confirmPasswordCon;
  final TextEditingController usernameCon;
  final TextEditingController sexualityCon;
  final TextEditingController genderCon;
  final VoidCallback previousStep;
  final VoidCallback nextStep;
  final GlobalKey<FormState> formKey;

  const SignupStepTwo({
    super.key,
    required this.emailCon,
    required this.passwordCon,
    required this.confirmPasswordCon,
    required this.usernameCon,
    required this.nextStep,
    required this.previousStep,
    required this.sexualityCon,
    required this.genderCon,
    required this.formKey,
  });

  @override
  State<SignupStepTwo> createState() => _SignupStepTwoState();
}

class _SignupStepTwoState extends State<SignupStepTwo> {
  String? username;
  String? email;

  final debounce = Debounce(milliseconds: 1000);

  @override
  initState() {
    super.initState();
    username = '';
    email = '';
  }

  @override
  void dispose() {
    debounce.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final MyColorsExtension myColors =
        Theme.of(context).extension<MyColorsExtension>()!;
    final ThemeData colors = Theme.of(context);

    void onChangedUsername(String value) {
      debounce.call(() {
        setState(() {
          username = value;
        });
        context.read<ValidInputStateCubit>().execute(
          usecase: GetUserByFilter(),
          params: GetUserByFilterParams(filter: value, type: 'username'),
        );
      });
    }

    void onChangedEmail(String value) {
      debounce.call(() {
        setState(() {
          email = value;
        });
        context.read<ValidInputStateCubit>().execute(
          usecase: GetUserByFilter(),
          params: GetUserByFilterParams(filter: value, type: 'email'),
        );
      });
    }

    return SizedBox(
      height: MediaQuery.of(context).size.height * .95,
      child: Column(
        children: [
          Spacer(),
          CustomContainer(
            position: 'top',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BestyTitle(
                  fontSize: 14,
                  color: Colors.white,
                  title: 'Basic info from you',
                ),
                SizedBox(height: 20),
                BestyDropdown(
                  list: genderList,
                  isRequired: true,
                  label: 'What is your gender identity? (Optional)',
                ),
                SizedBox(height: 20),
                BestyDropdown(
                  list: sexualityList,
                  isRequired: true,
                  label: 'What is your sexual orientation? (Optional)',
                ),
              ],
            ),
          ),
          CustomContainer(
            position: 'middle',
            child: Column(
              children: [
                BestyInput(
                  onChanged: (value) {
                    onChangedUsername(value);
                  },
                  controller: widget.usernameCon,
                  label: 'What is your username?',
                  validator: (value) {
                    if (value == null || value.isEmpty || value.length <= 3) {
                      return 'Please a valid name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                BestyInput(
                  onChanged: (value) {
                    onChangedEmail(value);
                  },

                  controller: widget.emailCon,
                  label: 'And your email address',
                  validator:
                      (value) =>
                          value!.isValidEmail()
                              ? null
                              : "Please enter a valid e-mail address",
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
                    widget.previousStep();
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
                    if (widget.formKey.currentState!.validate()) {
                      widget.nextStep();
                    } else {
                      return;
                    }
                  },
                  title: 'Next',
                  titleSize: 14,
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
