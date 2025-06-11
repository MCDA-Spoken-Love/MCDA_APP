import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mcda_app/common/blocs/delete_account/delete_account_bloc.dart';
import 'package:mcda_app/common/blocs/delete_account/delete_account_event.dart';
import 'package:mcda_app/common/blocs/delete_account/delete_account_state.dart';
import 'package:mcda_app/common/widgets/button/custom_button.dart';
import 'package:mcda_app/common/widgets/snackbar.dart';
import 'package:mcda_app/common/widgets/text/section_body.dart';
import 'package:mcda_app/common/widgets/text/sections_title.dart';
import 'package:mcda_app/core/configs/theme/my_colors_extension.dart';
import 'package:mcda_app/core/provider/theme.dart';
import 'package:mcda_app/presentation/auth/pages/signin.dart';
import 'package:provider/provider.dart';

class DeleteAccountWidget extends StatelessWidget {
  const DeleteAccountWidget({super.key});

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
          return BlocProvider(
            create: (context) => DeleteAccountBloc(),
            child: Consumer(
              builder: (context, ThemeNotifier themeNotifier, child) {
                return BlocListener<DeleteAccountBloc, DeleteAccountState>(
                  listener: (BuildContext context, DeleteAccountState state) {
                    if (state is DeleteAccountFailure) {
                      Navigator.pop(context);
                      GlobalSnackBar.show(
                        context,
                        state.message,
                        status: 'error',
                      );
                    }
                    if (state is AccountDeleted) {
                      Navigator.pop(context);
                      themeNotifier.toggleColorScheme('main');
                      if (themeNotifier.theme == 'dark') {
                        themeNotifier.toggleTheme();
                      }
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => SigninPage()),
                      );
                      GlobalSnackBar.show(
                        context,
                        state.message,
                        status: 'success',
                      );
                    }
                  },
                  child: BlocBuilder<DeleteAccountBloc, DeleteAccountState>(
                    builder: (BuildContext context, DeleteAccountState state) {
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
                              CustomButton(
                                isLoading: state is DeleteAccountLoading,
                                onPressed: () {
                                  BlocProvider.of<DeleteAccountBloc>(
                                    context,
                                  ).add(DeleteAccountCallback());
                                },
                                titleColor: colors.colorScheme.error,
                                backgroundColor: Colors.transparent,
                                title: 'Yes, please delete my account',
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
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
