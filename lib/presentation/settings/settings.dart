import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:mcda_app/common/widgets/button/elevated_custom_redirect.dart';
import 'package:mcda_app/common/widgets/containers/custom_container.dart';
import 'package:mcda_app/common/widgets/custom_scaffold/custom_scaffold.dart';
import 'package:mcda_app/core/provider/theme.dart';
import 'package:mcda_app/domain/usecases/auth/signout.dart';
import 'package:mcda_app/presentation/auth/pages/signin.dart';
import 'package:mcda_app/presentation/settings/pages/account_data/page/account_data.dart';
import 'package:mcda_app/presentation/settings/pages/app_info_page.dart';
import 'package:mcda_app/presentation/settings/pages/appearance_page.dart';
import 'package:mcda_app/presentation/settings/pages/credits_page.dart';
import 'package:mcda_app/presentation/settings/pages/privacy/privacy_page.dart';
import 'package:mcda_app/presentation/settings/pages/privacy_policy_page.dart';
import 'package:mcda_app/presentation/settings/pages/relationship_settings_page.dart';
import 'package:mcda_app/presentation/settings/pages/terms_and_conditions_page.dart';
import 'package:provider/provider.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  Future<void> logout() async {
    SignoutUseCase().call();
    await HydratedBloc.storage.clear();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScaffold.withChild(
        appBar: Text(
          'Settings',
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
        ),
        body: Column(
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
                Navigator.of(
                  context,
                ).push(MaterialPageRoute(builder: (context) => AccountData()));
              },
              containerPosition: 'top',
              title: 'Account data',
              icon: Icons.account_circle_outlined,
            ),
            ElevatedCustomRedirect(
              onPressed: () {
                Navigator.of(
                  context,
                ).push(MaterialPageRoute(builder: (context) => PrivacyPage()));
              },
              containerPosition: 'middle',
              title: 'Privacy',
              icon: Icons.privacy_tip_outlined,
            ),
            ElevatedCustomRedirect(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => RelationshipSettingsPage(),
                  ),
                );
              },
              containerPosition: 'bottom',
              title: 'Relationship Settings',
              icon: Icons.favorite_border_outlined,
            ),
            SizedBox(height: 14),
            ElevatedCustomRedirect(
              onPressed: () {
                Navigator.of(
                  context,
                ).push(MaterialPageRoute(builder: (context) => CreditsPage()));
              },
              containerPosition: 'top',
              title: 'Credits',
              icon: Icons.people_alt_outlined,
            ),
            ElevatedCustomRedirect(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => PrivacyPolicyPage()),
                );
              },
              containerPosition: 'middle',
              title: 'Privacy policy',
              icon: Icons.policy_outlined,
            ),
            ElevatedCustomRedirect(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => TermsAndConditionsPage(),
                  ),
                );
              },
              containerPosition: 'middle',
              title: 'Terms and conditions',
              icon: Icons.supervised_user_circle_outlined,
            ),
            ElevatedCustomRedirect(
              onPressed: () {
                Navigator.of(
                  context,
                ).push(MaterialPageRoute(builder: (context) => AppInfoPage()));
              },
              containerPosition: 'middle',
              title: 'App info',
              icon: Icons.info_outline,
            ),
            Consumer(
              builder: (context, ThemeNotifier themeNotifier, child) {
                return ElevatedCustomRedirect(
                  onPressed: () async {
                    themeNotifier.toggleColorScheme('main');
                    if (themeNotifier.theme == 'dark') {
                      themeNotifier.toggleTheme();
                    }
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => SigninPage()),
                    );
                    logout();
                  },
                  containerPosition: 'bottom',
                  title: 'Logout',
                  icon: Icons.logout_outlined,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
