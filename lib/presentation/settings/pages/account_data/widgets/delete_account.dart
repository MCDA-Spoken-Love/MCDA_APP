import 'package:flutter/material.dart';
import 'package:mcda_app/common/widgets/button/custom_button.dart';
import 'package:mcda_app/common/widgets/text/section_body.dart';
import 'package:mcda_app/common/widgets/text/sections_title.dart';

class DeleteAccount extends StatefulWidget {
  const DeleteAccount({super.key});

  @override
  State<DeleteAccount> createState() => _DeleteAccountState();
}

class _DeleteAccountState extends State<DeleteAccount> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ThemeData colors = Theme.of(context);

    Future openDialog() {
      return showModalBottomSheet(
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40.0),
        ),
        context: context,
        builder: (BuildContext bc) {
          return Container(
            height: size.height * 0.9,
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
