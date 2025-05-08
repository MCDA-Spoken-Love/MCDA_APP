import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mcda_app/common/button/button_state_cubit.dart';
import 'package:mcda_app/presentation/auth/pages/signin.dart';
import 'package:mcda_app/presentation/auth/pages/signup/widgets/signup_step_one.dart';
import 'package:mcda_app/presentation/auth/pages/signup/widgets/signup_step_two.dart';

import '../../../../../common/button/button_state.dart';
import '../../../../../common/widgets/button/basic_app_button.dart';
import '../../../../../data/models/signup_req_params.dart';
import '../../../../../domain/usecases/signup.dart';
import '../../../../home/pages/home.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  late int formStepper;
  final TextEditingController _fullnameCon = TextEditingController();
  final TextEditingController _usernameCon = TextEditingController();
  final TextEditingController _emailCon = TextEditingController();
  final TextEditingController _passwordCon = TextEditingController();
  final TextEditingController _confirmPasswordCon = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  initState() {
    super.initState();
    formStepper = 1;
  }

  void _nextStep() {
    if (formStepper <= 2) {
      setState(() {
        formStepper++;
      });
    }
  }

  Widget _createAccountButton(BuildContext context) {
    return Builder(
      builder: (context) {
        return BasicAppButton(
          title: 'Create Account',
          onPressed: () {
            context.read<ButtonStateCubit>().execute(
              usecase: SignupUseCase(),
              params: SignupReqParams(
                email: _emailCon.text,
                password: _passwordCon.text,
                username: _usernameCon.text,
                first_name: '',
                last_name: '',
                connection_code: '',
              ),
            );
          },
        );
      },
    );
  }

  Widget _signinText(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          const TextSpan(
            text: 'Do you have an account?',
            style: TextStyle(
              color: Color(0xff3B4054),
              fontWeight: FontWeight.w500,
            ),
          ),
          TextSpan(
            text: ' Sign In',
            style: const TextStyle(
              color: Color(0xff3461FD),
              fontWeight: FontWeight.w500,
            ),
            recognizer:
                TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SigninPage()),
                    );
                  },
          ),
        ],
      ),
    );
  }

  Widget stepSwitcher(BuildContext context) {
    switch (formStepper) {
      case 2:
        return SignupStepTwo(
          callback: _nextStep,
          emailCon: _emailCon,
          passwordCon: _passwordCon,
          confirmPasswordCon: _confirmPasswordCon,
          usernameCon: _usernameCon,
        );
      case 1:
      default:
        return SignupStepOne(
          nextStep: _nextStep,
          fullnameCon: _fullnameCon,
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
                  var snackBar = SnackBar(content: Text(state.errorMessage));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              },
              child: SafeArea(
                minimum: const EdgeInsets.only(top: 0, left: 16, right: 16),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(child: stepSwitcher(context)),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
