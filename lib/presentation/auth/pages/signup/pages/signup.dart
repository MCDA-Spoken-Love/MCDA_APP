import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mcda_app/common/blocs/button/button_state_cubit.dart';
import 'package:mcda_app/common/widgets/button/besty_button.dart';
import 'package:mcda_app/common/widgets/text/snackbar.dart';
import 'package:mcda_app/core/configs/theme/my_colors_extension.dart';
import 'package:mcda_app/presentation/auth/pages/signup/widgets/signup_step_one.dart';
import 'package:mcda_app/presentation/auth/pages/signup/widgets/signup_step_three.dart';
import 'package:mcda_app/presentation/auth/pages/signup/widgets/signup_step_two.dart';

import '../../../../../common/blocs/button/button_state.dart';
import '../../../../../data/models/signup_req_params.dart';
import '../../../../../domain/usecases/auth/signup.dart';
import '../../../../home/home.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  late int formStepper;
  final TextEditingController _firstNameCon = TextEditingController();
  final TextEditingController _lastNameCon = TextEditingController();
  final TextEditingController _usernameCon = TextEditingController();
  final TextEditingController _emailCon = TextEditingController();
  final TextEditingController _passwordCon = TextEditingController();
  final TextEditingController _confirmPasswordCon = TextEditingController();
  final TextEditingController _sexualityCon = TextEditingController(
    text: 'OTHER',
  );
  final TextEditingController _genderCon = TextEditingController(text: 'OTHER');
  bool _hasAcceptedPrivacyPolicy = false;
  bool _hasAcceptedTermsAndConditions = false;

  final _formKey = GlobalKey<FormState>();

  @override
  initState() {
    super.initState();
    formStepper = 1;
  }

  void _acceptPrivacyPolicy(bool? value) {
    setState(() {
      _hasAcceptedPrivacyPolicy = value ?? false;
    });
  }

  void _acceptTermsAndConditions(bool? value) {
    setState(() {
      _hasAcceptedTermsAndConditions = value ?? false;
    });
  }

  void _nextStep() {
    if (formStepper <= 3) {
      setState(() {
        formStepper++;
      });
    }
  }

  void _previousStep() {
    if (formStepper > 1) {
      setState(() {
        formStepper--;
      });
    }
  }

  Widget _createAccountButton() {
    final MyColorsExtension myColors =
        Theme.of(context).extension<MyColorsExtension>()!;
    return Builder(
      builder: (context) {
        return BestyButton(
          width: MediaQuery.of(context).size.width * .4,

          title: 'Create Account',
          titleSize: 10,
          backgroundColor: myColors.submitColor,
          titleColor: Colors.white,
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              context.read<ButtonStateCubit>().execute(
                usecase: SignupUseCase(),
                params: SignupReqParams(
                  email: _emailCon.text,
                  password1: _passwordCon.text,
                  password2: _confirmPasswordCon.text,
                  username: _usernameCon.text,
                  first_name: _firstNameCon.text,
                  last_name: _lastNameCon.text,
                  gender: _genderCon.text,
                  sexuality: _sexualityCon.text,
                  has_accepted_privacy_policy: _hasAcceptedPrivacyPolicy,
                  has_accepted_terms_and_conditions:
                      _hasAcceptedTermsAndConditions,
                ),
              );
            } else {
              return;
            }
          },
        );
      },
    );
  }

  Widget stepSwitcher() {
    switch (formStepper) {
      case 3:
        return SignupStepThree(
          formKey: _formKey,
          passwordCon: _passwordCon,
          confirmPasswordCon: _confirmPasswordCon,
          submit: _createAccountButton,
          previousStep: _previousStep,
          acceptPrivacyPolicy: _acceptPrivacyPolicy,
          acceptTermsAndConditions: _acceptTermsAndConditions,
          hasAcceptedPrivacyPolicy: _hasAcceptedPrivacyPolicy,
          hasAcceptedTermsAndConditions: _hasAcceptedTermsAndConditions,
        );
      case 2:
        return SignupStepTwo(
          formKey: _formKey,
          nextStep: _nextStep,
          previousStep: _previousStep,
          emailCon: _emailCon,
          passwordCon: _passwordCon,
          confirmPasswordCon: _confirmPasswordCon,
          usernameCon: _usernameCon,
          sexualityCon: _sexualityCon,
          genderCon: _genderCon,
        );
      case 1:
      default:
        return SignupStepOne(
          nextStep: _nextStep,
          firstNameCon: _firstNameCon,
          lastNameCon: _lastNameCon,
          formKey: _formKey,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/pink_hearts_logo_bg.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: BlocProvider(
            create: (context) => ButtonStateCubit(),
            child: BlocListener<ButtonStateCubit, ButtonState>(
              listener: (context, state) {
                if (state is ButtonSuccessState) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const HomePage()),
                  );
                }
                if (state is ButtonFailureState) {
                  GlobalSnackBar.show(
                    context,
                    state.errorMessage,
                    status: 'error',
                  );
                }
              },
              child: SafeArea(
                minimum: const EdgeInsets.only(top: 0, left: 16, right: 16),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    reverse: true,
                    child: stepSwitcher(),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
