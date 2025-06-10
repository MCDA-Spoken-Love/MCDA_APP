import 'package:flutter/material.dart';
import 'package:mcda_app/common/utils/validations.dart';
import 'package:mcda_app/common/widgets/button/custom_button.dart';
import 'package:mcda_app/common/widgets/input/input_field.dart';
import 'package:mcda_app/common/widgets/snackbar.dart';
import 'package:mcda_app/common/widgets/text/sections_title.dart';
import 'package:mcda_app/data/models/change_password_req_params.dart';
import 'package:mcda_app/domain/usecases/auth/change_password.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final TextEditingController _newPasswordCon = TextEditingController();
  final TextEditingController _newPasswordConfirmCon = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  void handleChangePassword() async {
    setState(() {
      _isLoading = true;
    });
    var result = await ChangePasswordUseCase().call(
      param: ChangePasswordReqParams(
        new_password1: _newPasswordCon.text,
        new_password2: _newPasswordConfirmCon.text,
      ),
    );
    result.fold(
      (failure) {
        GlobalSnackBar.show(context, failure, status: 'error');
      },
      (success) {
        GlobalSnackBar.show(context, success['detail'], status: 'success');
      },
    );
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
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
                isLoading: _isLoading,
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    handleChangePassword();
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
  }
}
