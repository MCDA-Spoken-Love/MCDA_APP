import 'package:flutter/material.dart';
import 'package:mcda_app/common/widgets/button/elevated_custom_redirect.dart';
import 'package:mcda_app/common/widgets/containers/custom_container.dart';
import 'package:mcda_app/common/widgets/custom_scaffold/custom_scaffold.dart';
import 'package:mcda_app/presentation/settings/pages/appearance_page.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScaffold.withChild(
        appBarChild: Text(
          'Settings',
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomContainer(
              position: 'unique',
              paddings: EdgeInsets.all(2.0),
              child: SizedBox(height: 1),
            ),
            SizedBox(height: 14),
            ElevatedCustomRedirect(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => AppearancePage()),
                );
              },
              containerPosition: 'unique',
              icon: Icons.palette_outlined,

              title: 'Appearance',
            ),
            SizedBox(height: 14),
            ElevatedCustomRedirect(
              onPressed: () {
                false;
              },
              containerPosition: 'top',
              title: 'Account data',
              icon: Icons.account_circle_outlined,
            ),
            ElevatedCustomRedirect(
              onPressed: () {
                false;
              },
              containerPosition: 'middle',
              title: 'Privacy',
              icon: Icons.privacy_tip_outlined,
            ),
            ElevatedCustomRedirect(
              onPressed: () {
                false;
              },
              containerPosition: 'bottom',
              title: 'Relationship Settings',
              icon: Icons.favorite_border_outlined,
            ),
            SizedBox(height: 14),
            ElevatedCustomRedirect(
              onPressed: () {
                false;
              },
              containerPosition: 'top',
              title: 'Credits',
              icon: Icons.people_alt_outlined,
            ),
            ElevatedCustomRedirect(
              onPressed: () {
                false;
              },
              containerPosition: 'middle',
              title: 'Privacy policy',
              icon: Icons.policy_outlined,
            ),
            ElevatedCustomRedirect(
              onPressed: () {
                false;
              },
              containerPosition: 'middle',
              title: 'Terms of use',
              icon: Icons.supervised_user_circle_outlined,
            ),
            ElevatedCustomRedirect(
              onPressed: () {
                false;
              },
              containerPosition: 'bottom',
              title: 'App info',
              icon: Icons.info_outline,
            ),
          ],
        ),
      ),
    );
  }
}
