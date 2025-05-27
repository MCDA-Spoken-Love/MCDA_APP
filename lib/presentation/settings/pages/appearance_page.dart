import 'package:flutter/material.dart';
import 'package:mcda_app/common/utils/string_manipulations.dart';
import 'package:mcda_app/common/widgets/button/segmented_custom_button.dart';
import 'package:mcda_app/common/widgets/routing/go_back/go_back.dart';
import 'package:mcda_app/common/widgets/text/sections_title.dart';
import 'package:mcda_app/core/constants/colors.dart';
import 'package:mcda_app/core/provider/theme.dart';
import 'package:provider/provider.dart';

class AppearancePage extends StatefulWidget {
  const AppearancePage({super.key});

  @override
  State<AppearancePage> createState() => _AppearancePageState();
}

class _AppearancePageState extends State<AppearancePage> {
  ThemeChoices themeOption = ThemeChoices.light;

  void onThemeChange(choice) {
    setState(() => themeOption = choice);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GoBack(title: 'Appearance'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SectionTitle('Theme'),
                Consumer(
                  builder: (context, ThemeNotifier themeNotifier, child) {
                    return SegmentedCustomButton(
                      options: ThemeChoices.values,
                      labelBuilder: (choice) => Text(choice.name.toCapitalized),
                      selected: themeOption,
                      onSelectionChanged: (choice) {
                        onThemeChange(choice);
                        themeNotifier.toggleColorTheme(choice.name);
                      },
                    );
                  },
                ),
              ],
            ),
            SizedBox(height: 28),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SectionTitle('Colors'),
                Consumer(
                  builder:
                      (context, ThemeNotifier themeNotifier, child) =>
                          FloatingActionButton(
                            heroTag: 'appColorSchemeDynamic',
                            onPressed: () {
                              themeNotifier.toggleColorScheme('dynamic');
                            },
                            child: Icon(Icons.add),
                          ),
                ),
                Consumer(
                  builder:
                      (context, ThemeNotifier themeNotifier, child) =>
                          FloatingActionButton(
                            heroTag: 'appColorSchemeMain',
                            onPressed: () {
                              themeNotifier.toggleColorScheme('main');
                            },
                            child: Icon(Icons.add),
                          ),
                ),
                Consumer(
                  builder: (context, ThemeNotifier themeNotifier, child) {
                    return SegmentedCustomButton(
                      options: ThemeChoices.values,
                      labelBuilder: (choice) => Text(choice.name.toCapitalized),
                      selected: themeOption,
                      onSelectionChanged: (choice) {
                        onThemeChange(choice);
                        themeNotifier.toggleColorTheme(choice.name);
                      },
                    );
                  },
                ),
              ],
            ),

            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
