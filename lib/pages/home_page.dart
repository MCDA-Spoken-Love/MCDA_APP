import 'package:flutter/material.dart';
import 'package:mcda_app/provider/theme.dart';
import 'package:provider/provider.dart';

import '../classes/my_colors_extension.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int valueHolder = 1;

  @override
  Widget build(BuildContext context) {
    final MyColorsExtension myColors = Theme.of(context).extension<MyColorsExtension>()!;
    return Scaffold(
      appBar: AppBar(title: Text('Theme Changer')),
      backgroundColor: myColors.backgroundColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Consumer(
              builder:
                  (context, ThemeNotifier themeNotifier, child) =>
                      SwitchListTile(
                        title: Text("Dark Mode"),
                        onChanged: (val) {
                          themeNotifier.toggleTheme();
                        },
                        value: themeNotifier.theme == 'dark' ? true : false,
                      ),
            ),
            Consumer(
              builder:
                  (context, ThemeNotifier themeNotifier, child) =>
                      FloatingActionButton(
                        backgroundColor: myColors.accentColor,
                        onPressed: () {
                          themeNotifier.toggleColorScheme('red');
                        },
                        child: Icon(Icons.add),
                      ),
            ),
            Consumer(
              builder:
                  (context, ThemeNotifier themeNotifier, child) =>
                      FloatingActionButton(
                        child: Icon(Icons.add),
                        onPressed: () {
                          themeNotifier.toggleColorScheme('blue');
                        },
                      ),
            ),
            Consumer(
              builder:
                  (context, ThemeNotifier themeNotifier, child) =>
                      FloatingActionButton(
                        child: Icon(Icons.add),
                        onPressed: () {
                          themeNotifier.toggleColorScheme('main');
                        },
                      ),
            ),
          ],
        ),
      ),
    );
  }
}
