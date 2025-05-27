import 'package:flutter/material.dart';
import 'package:mcda_app/common/widgets/custom_scaffold/custom_scaffold.dart';
import 'package:mcda_app/common/widgets/routing/go_back/go_back.dart';
import 'package:mcda_app/common/widgets/terms_policy/terms_and_conditions_content.dart';

class TermsAndConditionsPage extends StatelessWidget {
  const TermsAndConditionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold.withChild(
      appBarChild: GoBack(title: 'Terms and Conditions'),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TermsAndConditionsContent(),
      ),
    );
  }
}
