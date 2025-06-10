import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mcda_app/common/widgets/terms_policy/terms_and_conditions_content.dart';
import 'package:mcda_app/common/widgets/text/besty_title.dart';

class TermsAndConditions extends StatelessWidget {
  const TermsAndConditions({super.key});

  @override
  Widget build(BuildContext context) {
    TextStyle linkStyle = TextStyle(color: Colors.blue);
    Size size = MediaQuery.of(context).size;
    final ThemeData colors = Theme.of(context);

    return SizedBox(
      width: MediaQuery.of(context).size.width * .7,
      child: RichText(
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        text: TextSpan(
          children: <TextSpan>[
            TextSpan(text: 'Please read and accept our '),
            TextSpan(
              text: 'terms and conditions',
              style: linkStyle,
              recognizer:
                  TapGestureRecognizer()
                    ..onTap = () {
                      _openDialog(context, size, colors);
                    },
            ),
            TextSpan(text: ' to continue.'),
          ],
        ),
      ),
    );
  }

  Future<dynamic> _openDialog(
    BuildContext context,
    Size size,
    ThemeData colors,
  ) {
    return showModalBottomSheet(
      isScrollControlled: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40.0)),
      context: context,
      builder: (BuildContext bc) {
        return Container(
          height: size.height * 0.9,
          decoration: BoxDecoration(
            color: colors.colorScheme.surface,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(40.0),
              topLeft: Radius.circular(40.0),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: ListView(
              physics: ClampingScrollPhysics(),
              children: [
                BestyTitle(title: 'Terms and Conditions'),
                TermsAndConditionsContent(),
              ],
            ),
          ),
        );
      },
    );
  }
}
