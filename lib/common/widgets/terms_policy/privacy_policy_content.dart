import 'package:flutter/material.dart';
import 'package:mcda_app/common/widgets/text/section_body.dart';
import 'package:mcda_app/common/widgets/text/sections_title.dart';

class PrivacyPolicyContent extends StatelessWidget {
  const PrivacyPolicyContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 8),
          Text(
            'Effective Date: 19/05/2025',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
          SizedBox(height: 16),

          SectionTitle('1. Introduction'),
          SectionBody(
            'This Privacy Policy explains how "MCDA Spoken Love" collects, uses, and discloses information about you when you use our mobile application ("App"). By using the App, you agree to the terms of this policy.',
          ),

          SectionTitle('2. Information We Collect'),
          SectionBody(
            'We may collect the following types of information:\n'
            '- **Personal Information**: such as name, email address, and profile details.\n'
            '- **Usage Data**: including interactions, features used, and device information.\n',
          ),

          SectionTitle('3. How We Use Your Information'),
          SectionBody(
            'We use the information we collect to:\n'
            '- Provide and maintain the App.\n'
            '- Personalize user experience.\n'
            '- Send updates, notifications, or promotional materials.\n'
            '- Improve security and troubleshoot issues.',
          ),

          SectionTitle('4. Sharing Your Information'),
          SectionBody(
            'We do not sell your personal information. We may share it with:\n'
            '- Service providers who assist with app operations.\n'
            '- Legal authorities, if required by law.\n'
            '- Other users, if you choose to share content publicly.',
          ),

          SectionTitle('5. Data Retention'),
          SectionBody(
            'We retain your information as long as necessary to provide our services and comply with legal obligations. You may request deletion of your data at any time.',
          ),

          SectionTitle('6. Your Rights'),
          SectionBody(
            'Depending on your location, you may have the right to:\n'
            '- Access the information we hold about you.\n'
            '- Request correction or deletion of your data.\n'
            '- Object to or restrict certain processing activities.',
          ),

          SectionTitle('7. Security'),
          SectionBody(
            'We use reasonable safeguards to protect your data. However, no method of transmission or storage is 100% secure.',
          ),

          SectionTitle('8. Children\'s Privacy'),
          SectionBody(
            'The App is not intended for children under 13. We do not knowingly collect personal data from children without parental consent.',
          ),

          SectionTitle('9. Changes to This Policy'),
          SectionBody(
            'We may update this Privacy Policy from time to time. We will notify you of significant changes by posting a notice in the App.',
          ),

          SectionTitle('10. Contact Us'),
          SectionBody(
            'If you have questions or concerns about these Terms, please contact us at:\n\n'
            'MCDA Spoken Love\n'
            'Email: msallesblanco@gmail.com\n'
            'Address: CLSW 300B, Bloco 4, Apt 107, Edifício Diamond, Brasília/DF, 70673-083\n',
          ),
        ],
      ),
    );
  }
}
