import 'package:flutter/material.dart';
import 'package:mcda_app/common/widgets/routing/go_back/go_back.dart';
import 'package:mcda_app/common/widgets/text/sections_title.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrivacyPage extends StatefulWidget {
  const PrivacyPage({super.key});

  @override
  State<PrivacyPage> createState() => _PrivacyPageState();
}

class _PrivacyPageState extends State<PrivacyPage> {
  bool? statusVisibilityEnabled = false;
  bool? biometricLockEnabled;

  Future<Map<String, bool>> getPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return {"biometric_lock": prefs.getBool('biometric_lock') ?? false};
  }

  void setBiometricLock(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('biometric_lock', value);
    setState(() {
      biometricLockEnabled = value;
    });
  }

  @override
  void initState() {
    super.initState();
    getPrefs().then((res) {
      setState(() {
        biometricLockEnabled = res['biometric_lock'];
      });
    });
    setState(() {
      statusVisibilityEnabled = false;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GoBack(title: 'privacy'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionTitle('Status'),
            SwitchListTile(
              contentPadding: EdgeInsets.all(0),
              title: Text('Allow my status to be visible'),
              value: statusVisibilityEnabled ?? false,
              onChanged: (bool value) {},
            ),
            SizedBox(height: 20),
            SectionTitle('App lock'),
            SwitchListTile(
              isThreeLine: true,
              contentPadding: EdgeInsets.all(0),
              title: Text('Unlock with biometrics'),
              subtitle: Text(
                'When enabled, you’ll need to use fingerprint, face or other unique identifiers to open this app.',
              ),
              value: biometricLockEnabled ?? false,
              onChanged: (bool value) {
                setBiometricLock(value);
              },
            ),
          ],
        ),
      ),
    );
  }
}
