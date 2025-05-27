import 'package:flutter/material.dart';
import 'package:mcda_app/common/widgets/routing/go_back/go_back.dart';
import 'package:mcda_app/common/widgets/terms_policy/privacy_policy_content.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GoBack(title: 'Privacy Policy'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: PrivacyPolicyContent(),
      ),
    );
  }
}
