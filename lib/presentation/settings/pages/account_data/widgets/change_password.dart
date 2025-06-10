import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mcda_app/common/blocs/change_password/change_password_bloc.dart';
import 'package:mcda_app/common/blocs/change_password/change_password_event.dart';
import 'package:mcda_app/common/blocs/change_password/change_password_state.dart';
import 'package:mcda_app/common/utils/validations.dart';
import 'package:mcda_app/common/widgets/button/custom_button.dart';
import 'package:mcda_app/common/widgets/input/input_field.dart';
import 'package:mcda_app/common/widgets/snackbar.dart';
import 'package:mcda_app/common/widgets/text/sections_title.dart';

class ChangePasswordWidget extends StatefulWidget {
  const ChangePasswordWidget({super.key});

  @override
  State<ChangePasswordWidget> createState() => _ChangePasswordWidgetState();
}

class _ChangePasswordWidgetState extends State<ChangePasswordWidget> {
  final TextEditingController _newPasswordCon = TextEditingController();
  final TextEditingController _newPasswordConfirmCon = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChangePasswordBloc(),
      child: BlocListener<ChangePasswordBloc, ChangePasswordState>(
        listener: (BuildContext context, ChangePasswordState state) {
          if (state is ChangePasswordFailure) {
            GlobalSnackBar.show(context, state.message, status: 'error');
          }
          if (state is PasswordChanged) {
            GlobalSnackBar.show(context, state.message, status: 'success');
          }
        },
        child: BlocBuilder<ChangePasswordBloc, ChangePasswordState>(
          builder: (BuildContext context, ChangePasswordState state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SectionTitle('Account password'),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      InputField(
                        controller: _newPasswordCon,
                        label: 'New password',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          } else if (value.isValidPassword() == false) {
                            return 'Password should contain upper, lower and digit and be more than 8 characters long';
                          }
                          return null;
                        },
                        inputType: 'password',
                      ),
                      SizedBox(height: 20),
                      InputField(
                        controller: _newPasswordConfirmCon,
                        label: 'Confirm password',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          } else if (value != _newPasswordCon.text) {
                            return 'Make sure your passwords match';
                          }
                          return null;
                        },
                        inputType: 'password',
                      ),
                      SizedBox(height: 20),
                      CustomButton(
                        isLoading: state is ChangePasswordLoading,
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            BlocProvider.of<ChangePasswordBloc>(context).add(
                              ChangePasswordCallback(
                                new_password1: _newPasswordCon.text,
                                new_password2: _newPasswordConfirmCon.text,
                              ),
                            );
                          } else {
                            return;
                          }
                        },
                        title: 'Change password',
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
