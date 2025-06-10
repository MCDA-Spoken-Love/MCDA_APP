import 'package:flutter/material.dart';
import 'package:mcda_app/common/widgets/button/custom_button.dart';
import 'package:mcda_app/common/widgets/snackbar.dart';
import 'package:mcda_app/common/widgets/text/section_body.dart';
import 'package:mcda_app/common/widgets/text/sections_title.dart';
import 'package:mcda_app/core/configs/theme/my_colors_extension.dart';
import 'package:mcda_app/core/provider/theme.dart';
import 'package:mcda_app/domain/usecases/user/delete_account.dart';
import 'package:mcda_app/presentation/auth/pages/signin.dart';
import 'package:provider/provider.dart';

class DeleteAccount extends StatefulWidget {
  const DeleteAccount({super.key});

  @override
  State<DeleteAccount> createState() => _DeleteAccountState();
}

class _DeleteAccountState extends State<DeleteAccount> {
  bool _isLoading = false;

  void _deleteAccount() async {
    setState(() => _isLoading = true);
    var response = await DeleteAccountUseCase().call();
    response.fold(
      (error) {
        Navigator.pop(context);
        GlobalSnackBar.show(context, error, status: 'error');
      },
      (success) {
        Navigator.pop(context);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => SigninPage()),
        );
        GlobalSnackBar.show(context, success['message'], status: 'success');
      },
    );
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    ThemeData colors = Theme.of(context);
    MyColorsExtension myColorsExtension =
        colors.extension<MyColorsExtension>()!;

    double sheetHeight = MediaQuery.of(context).size.height * .6;
    Future openDialog() {
      return showModalBottomSheet(
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40.0),
        ),
        context: context,
        builder: (BuildContext bc) {
          return Container(
            height: sheetHeight,
            decoration: BoxDecoration(
              color: colors.colorScheme.surface,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20.0),
                topLeft: Radius.circular(20.0),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: ListView(
                physics: ClampingScrollPhysics(),
                children: [
                  SectionTitle('Account deletion'),
                  SizedBox(height: 20),
                  SectionBody(
                    'You are about to delete your MCDA account. Be sure that you are certain of this decision, for this action cannot be reverted. Once deleted, your account is permanently gone, for the sake of data-security of the information that was shared here. ',
                  ),
                  SizedBox(height: 8),
                  SectionBody(
                    'Are you certain you desire to terminate your account?',
                  ),
                  SizedBox(height: 23),
                  CustomButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    backgroundColor: myColorsExtension.submitColor,
                    title: 'No, I have changed my mind',
                  ),
                  SizedBox(height: 14),
                  Consumer(
                    builder: (context, ThemeNotifier themeNotifier, child) {
                      return CustomButton(
                        isLoading: _isLoading,
                        onPressed: () {
                          _deleteAccount();
                          themeNotifier.toggleColorScheme('main');
                          if (themeNotifier.theme == 'dark') {
                            themeNotifier.toggleTheme();
                          }
                        },
                        titleColor: colors.colorScheme.error,
                        backgroundColor: Colors.transparent,
                        title: 'Yes, please delete my account',
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle('Delete account'),
        CustomButton(
          onPressed: () {
            openDialog();
          },
          title: 'Delete your account',
          error: true,
        ),
      ],
    );
  }
}
