import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mcda_app/common/utils/is_valid_email.dart';
import 'package:mcda_app/common/widgets/button/besty_button.dart';
import 'package:mcda_app/common/widgets/input/besty_input.dart';
import 'package:mcda_app/common/widgets/text/besty_title.dart';

import '../../../common/button/button_state.dart';
import '../../../common/button/button_state_cubit.dart';
import '../../../data/models/signin_req_params.dart';
import '../../../domain/usecases/signin.dart';
import '../../home/pages/home.dart';
import 'signup/pages/signup.dart';

class SigninPage extends StatelessWidget {
  SigninPage({super.key});

  final TextEditingController _emailCon = TextEditingController();
  final TextEditingController _passwordCon = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    ThemeData colors = Theme.of(context);

    return Scaffold(
      backgroundColor: colors.primaryColor,
      body: SizedBox.expand(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/hearts_bg.png"),
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
                minimum: const EdgeInsets.only(top: 50, right: 16, left: 16),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Image(image: AssetImage('assets/full_logo.png')),
                        _signin(),
                        const SizedBox(height: 20),
                        _emailField(),
                        const SizedBox(height: 20),
                        _password(),
                        const SizedBox(height: 20),
                        _createAccountButton(context),
                        const SizedBox(height: 20),
                        _signup(context, colors),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _signin() {
    return BestyTitle(title: 'Turn your words into love');
  }

  Widget _emailField() {
    return BestyInput(
      controller: _emailCon,
      label: 'Email',
      validator:
          (input) =>
              input!.isValidEmail()
                  ? null
                  : "Please enter a valid e-mail address",
    );
  }

  Widget _password() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        BestyInput(
          controller: _passwordCon,
          label: 'Password',
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your password';
            }
            return null;
          },
          inputType: 'password',
        ),
        TextButton(
          style: TextButton.styleFrom(
            foregroundColor: Colors.white,
            textStyle: TextStyle(fontSize: 16),
          ),
          onPressed: () {
            // TODO: Create forgot password page and api connection
            return;
          },
          child: Text('Forgot your password?'),
        ),
      ],
    );
  }

  Widget _createAccountButton(BuildContext context) {
    return Builder(
      builder: (context) {
        return BestyButton(
          title: 'Login',
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              // If the form is valid, display a snack bar. In the real world,
              // you'd often call a server or save the information in a database.
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text('Processing Data')));
            }
            context.read<ButtonStateCubit>().execute(
              usecase: SigninUseCase(),
              params: SigninReqParams(
                email: _emailCon.text,
                password: _passwordCon.text,
              ),
            );
          },
        );
      },
    );
  }

  Widget _signup(BuildContext context, ThemeData colors) {
    return BestyButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SignupPage()),
        );
      },
      title: 'Don\'t have an account? Sign up!',
      titleSize: 14,
      backgroundColor: Colors.white,
      titleColor: colors.highlightColor,
    );
  }
}
