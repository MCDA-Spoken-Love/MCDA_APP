import 'package:flutter/material.dart';
import 'package:mcda_app/common/widgets/text/section_body.dart';
import 'package:mcda_app/common/widgets/text/sections_title.dart';

class TermsAndConditionsContent extends StatelessWidget {
  const TermsAndConditionsContent({super.key});

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

          SectionTitle('1. Eligibility'),
          SectionBody(
            'You must be at least 13 years old (or the minimum age in your jurisdiction) to use this App. If you\'re under 18, you must have parental or guardian consent.',
          ),

          SectionTitle('2. Use of the App'),
          SectionBody(
            'You agree to use the App only for lawful purposes and in accordance with these Terms. You must not:\n'
            '- Use the App for any illegal or unauthorized purpose.\n'
            '- Modify, copy, or distribute the App or any part of it without our permission.\n'
            '- Attempt to gain unauthorized access to any part of the App or its systems.',
          ),

          SectionTitle('3. User Accounts'),
          SectionBody(
            'All features require you to create an account. You agree to provide accurate information and keep your login credentials secure. You are responsible for all activities under your account.',
          ),

          SectionTitle('4. Intellectual Property'),
          SectionBody(
            'All content, features, and functionality of the App—including but not limited to text, graphics, logos, and code—are owned by or licensed to "MCDA Spoken Love" and protected by intellectual property laws.',
          ),

          SectionTitle('5. Privacy'),
          SectionBody(
            'Your privacy is important to us. Please review our Privacy Policy to understand how we collect, use, and share your personal data.',
          ),

          SectionTitle('6. In-App Purchases'),
          SectionBody(
            'The App may offer in-app purchases. All purchases are final and non-refundable, except as required by law or specified in our refund policy. Prices may change without notice.',
          ),

          SectionTitle('7. Third-Party Services'),
          SectionBody(
            'The App may include links to or integration with third-party services. We are not responsible for the content, policies, or practices of any third-party websites or services.',
          ),

          SectionTitle('8. Disclaimers'),
          SectionBody(
            'The App is provided "as is" without warranties of any kind. We do not guarantee that the App will be error-free, secure, or continuously available.',
          ),

          SectionTitle('9. Limitation of Liability'),
          SectionBody(
            'To the fullest extent permitted by law, we will not be liable for any indirect, incidental, special, or consequential damages resulting from your use of or inability to use the App.',
          ),

          SectionTitle('10. Termination'),
          SectionBody(
            'We may suspend or terminate your access to the App at any time, with or without notice, for conduct that we believe violates these Terms or is harmful to other users or us.',
          ),

          SectionTitle('11. Changes to Terms'),
          SectionBody(
            'We may update these Terms from time to time. Changes will be effective upon posting. Continued use of the App after changes means you accept the updated Terms.',
          ),

          SectionTitle('12. Governing Law'),
          SectionBody(
            'These Terms are governed by the laws of Brasil/DF, without regard to conflict of law principles. Any disputes shall be resolved in the courts of Distrito Federal.',
          ),

          SectionTitle('13. Contact Us'),
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
