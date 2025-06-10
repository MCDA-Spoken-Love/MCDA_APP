import 'package:flutter/material.dart';
import 'package:mcda_app/common/widgets/routing/go_back/go_back.dart';
import 'package:mcda_app/presentation/settings/pages/account_data/widgets/change_password.dart';
import 'package:mcda_app/presentation/settings/pages/account_data/widgets/delete_account.dart';

class AccountData extends StatelessWidget {
  const AccountData({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GoBack(title: 'Account Data'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [ChangePasswordWidget(), DeleteAccountWidget()],
          ),
        ),
      ),
    );
  }
}
