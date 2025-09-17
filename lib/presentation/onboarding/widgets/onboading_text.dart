import 'package:flutter/material.dart';

class OnboadingText extends StatelessWidget {
  const OnboadingText({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData colors = Theme.of(context);

    return Column(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                RichText(
                  text: TextSpan(
                    text: 'Thank you for choosing to use ',
                    style: TextStyle(
                      fontSize: 14,
                      color: colors.canvasColor,
                      fontFamily: 'BestyBeige',
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: ' MCDA',
                        style: TextStyle(
                          color: colors.hintColor,
                          fontSize: 18,
                          fontFamily: 'BestyBeige',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 28),
            Text(
              'This is where it gets fun. Have your loved one close by and let’s start the party!',
              style: TextStyle(
                fontFamily: 'BestyBeige',
                color: colors.canvasColor,
                fontSize: 12,
              ),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 28),
          ],
        ),
      ],
    );
  }
}
