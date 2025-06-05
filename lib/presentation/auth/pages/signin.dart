import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mcda_app/common/utils/validations.dart';
import 'package:mcda_app/common/widgets/button/besty_button.dart';
import 'package:mcda_app/common/widgets/input/besty_input.dart';
import 'package:mcda_app/common/widgets/text/besty_title.dart';
import 'package:mcda_app/presentation/auth/pages/signup/pages/signup.dart';
import 'package:mcda_app/presentation/home/pages/home.dart';

import '../../../common/blocs/button/button_state.dart';
import '../../../common/blocs/button/button_state_cubit.dart';
import '../../../data/models/signin_req_params.dart';
import '../../../domain/usecases/signin.dart';

class SigninPage extends StatelessWidget {
  SigninPage({super.key});

  final TextEditingController _emailCon = TextEditingController(
    text: 'msallesblanco@gmail.com',
  );
  final TextEditingController _passwordCon = TextEditingController(
    text: 'Shiro744760@',
  );
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    ThemeData colors = Theme.of(context);

    return Scaffold(
      body: SizedBox.expand(
        child: Container(
          decoration: BoxDecoration(
            color: colors.colorScheme.primary,
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
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                }
                if (state is ButtonFailureState) {
                  var snackBar = SnackBar(
                    content: Text(state.errorMessage),
                    backgroundColor: colors.colorScheme.error,
                  );
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
                        _loginButton(context),
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

  Widget _loginButton(BuildContext context) {
    return Builder(
      builder: (context) {
        return BestyButton(
          title: 'Login',
          backgroundColor: Theme.of(context).highlightColor,
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              context.read<ButtonStateCubit>().execute(
                usecase: SigninUseCase(),
                params: SigninReqParams(
                  email: _emailCon.text,
                  password: _passwordCon.text,
                ),
              );
            }
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
