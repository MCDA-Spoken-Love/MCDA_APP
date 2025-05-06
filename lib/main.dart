import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mcda_app/core/configs/theme/theme_changer.dart';
import 'package:mcda_app/core/provider/theme.dart';
import 'package:mcda_app/pages/splash_screen.dart';
import 'package:provider/provider.dart';

Future main() async {
  await dotenv.load(fileName: ".env");

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
    return DynamicColorBuilder(
      builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
        return ChangeNotifierProvider(
          create: (_) => ThemeNotifier(),
          child: Consumer<ThemeNotifier>(
            builder: (context, ThemeNotifier themeNotifier, child) {
              return MaterialApp(
                title: 'MCDA_APP',
                theme: themeChanger(themeNotifier, lightDynamic, darkDynamic),
                home: SplashScreen(),
              );
            },
          ),
        );
      },
    );
  }
}
