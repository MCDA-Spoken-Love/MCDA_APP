import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/provider/theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int valueHolder = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('MCDA')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add), // *4
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(30, 40, 30, 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
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
                        onPressed: () {
                          themeNotifier.toggleColorScheme('main');
                        },
                        child: Icon(Icons.add),
                      ),
            ),
            Text(
              'NAME',
              style: TextStyle(
                // *5
                letterSpacing: 2,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Vinay :)',
              style: TextStyle(
                letterSpacing: 2,
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),
            Text('CURRENT AGE', style: TextStyle(letterSpacing: 2)),
            const SizedBox(height: 10),
            Text(
              'ggg',
              style: TextStyle(
                letterSpacing: 2,
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),
            Text('CONTACT', style: TextStyle(letterSpacing: 2)),
            const SizedBox(height: 10),
            Row(
              children: <Widget>[
                Icon(Icons.email),
                const SizedBox(width: 10),
                Text(
                  'xyz@gmail.com',
                  style: TextStyle(letterSpacing: 1, fontSize: 18),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
