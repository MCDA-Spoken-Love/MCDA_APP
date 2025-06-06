import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mcda_app/common/blocs/auth/auth_state.dart';
import 'package:mcda_app/common/blocs/auth/auth_state_cubit.dart';
import 'package:mcda_app/core/configs/scaffold/scaffold_messenger_key.dart';
import 'package:mcda_app/core/configs/theme/my_colors_extension.dart';
import 'package:mcda_app/core/configs/theme/theme_changer.dart';
import 'package:mcda_app/core/provider/theme.dart';
import 'package:mcda_app/presentation/auth/pages/signin.dart';
import 'package:mcda_app/presentation/home/pages/home.dart';
import 'package:mcda_app/presentation/splash_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light, // Or Brightness.dark
      systemNavigationBarColor: Colors.transparent,
    ),
  );
  runApp(const MyHomePage());
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

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
              return BlocProvider(
                create: (context) => AuthStateCubit()..appStarted(),
                child: MaterialApp(
                  scaffoldMessengerKey: rootScaffoldMessengerKey,
                  title: 'MCDA_APP',
                  theme: themeChanger(
                    context,
                    themeNotifier,
                    lightDynamic,
                    darkDynamic,
                  ),
                  home: BlocBuilder<AuthStateCubit, AuthState>(
                    builder: (context, state) {
                      if (state is Authenticated) {
                        final MyColorsExtension myColors =
                            Theme.of(context).extension<MyColorsExtension>()!;
                        SystemChrome.setSystemUIOverlayStyle(
                          SystemUiOverlayStyle(
                            statusBarColor:
                                myColors.translucentColor, // Status bar color
                          ),
                        );
                        return HomePage();
                      }
                      if (state is Unauthenticated) {
                        return SigninPage();
                      }

                      return SplashScreen();
                    },
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
