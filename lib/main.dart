import 'package:flutter/material.dart';
import 'package:mcda_app/pages/splash_screen.dart';
import 'package:mcda_app/provider/theme.dart';
import 'package:mcda_app/utils/colors.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyHomePage(title: 'Flutter Demo Home Page'));
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeNotifier(),
      child: Consumer<ThemeNotifier>(
        builder: (context, ThemeNotifier themeNotifier, child) {
          return MaterialApp(
            title: 'MCDA_APP',
            theme: themeChanger(themeNotifier),
            home: SplashScreen(),
          );
        },
      ),
    );
  }
}
