import 'package:flutter/material.dart';
import 'package:mcda_app/provider/theme.dart';
import 'package:provider/provider.dart';

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
      appBar: AppBar(title: Text('Theme Changer')),
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
                        value: themeNotifier.darkTheme,
                      ),
            ),
            Card(child: ListTile(title: Text("Card Widget"))),
            const SizedBox(height: 10.0),
            Slider(
              value: valueHolder.toDouble(),
              min: 1,
              max: 100,
              divisions: 100,
              label: '${valueHolder.round()}',
              onChanged: (double newValue) {
                setState(() {
                  valueHolder = newValue.round();
                });
              },
              semanticFormatterCallback: (double newValue) {
                return '${newValue.round()}';
              },
            ),
            SizedBox(height: 8.0),
            Text('$valueHolder', style: TextStyle(fontSize: 22)),
            SizedBox(height: 24.0),
            TextButton(
              style: ButtonStyle(
                foregroundColor: WidgetStateProperty.all<Color>(Colors.blue),
              ),
              onPressed: () {},
              child: Text('TextButton'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {},
      ),
    );
  }
}
