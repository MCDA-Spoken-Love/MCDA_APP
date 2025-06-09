import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_auth/local_auth.dart';
import 'package:logger/logger.dart';
import 'package:mcda_app/common/widgets/routing/navbar/navbar.dart';
import 'package:mcda_app/common/widgets/text/besty_title.dart';
import 'package:mcda_app/presentation/settings/settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../bloc/user_display_cubit.dart';
import '../bloc/user_display_state.dart';

Logger logger = Logger(
  printer: PrettyPrinter(methodCount: 0, colors: true, printEmojis: true),
);

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPageIndex = 1;
  bool _authorized = false;
  bool? biometricLockEnabled;

  final LocalAuthentication auth = LocalAuthentication();

  Future<Map<String, dynamic>> getPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return {
      "biometric_lock": prefs.getBool('biometric_lock') ?? false,
      "app_theme": prefs.getString('theme'),
      "app_scheme": prefs.getString('scheme'),
    };
  }

  Future<void> _authenticate() async {
    bool authenticated = false;
    try {
      setState(() {
        _authorized = true;
      });
      authenticated = await auth.authenticate(
        localizedReason: 'Authenticate to access the app\'s functionalities',
        options: const AuthenticationOptions(stickyAuth: true),
      );
    } on PlatformException catch (e) {
      logger.e(e);
      setState(() {
        _authorized = false;
      });
      return;
    }
    if (!mounted) {
      return;
    }

    setState(() {
      _authorized = authenticated;
    });
  }

  void _handleAuth() {
    getPrefs().then((res) {
      bool? biometricLockEnabledRes = res['biometric_lock'];
      setState(() {
        biometricLockEnabled = biometricLockEnabledRes;
      });
      auth.isDeviceSupported().then((bool isSupported) {
        if (isSupported && biometricLockEnabledRes!) {
          _authenticate();
        } else {
          setState(() {
            _authorized = true;
          });
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _handleAuth();

    final cubit = context.read<UserDisplayCubit>();
    if (cubit.state is UserLoading) {
      cubit.displayUser();
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      currentPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeColors = Theme.of(context);

    return Scaffold(
      extendBody: true,
      bottomNavigationBar:
          _authorized
              ? Navbar(
                onItemTapped: _onItemTapped,
                currentPageIndex: currentPageIndex,
              )
              : null,
      body: BlocBuilder<UserDisplayCubit, UserDisplayState>(
        builder: (context, state) {
          if (_authorized) {
            if (state is UserLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is LoadUserFailure) {
              return Center(child: Text(state.errorMessage));
            }
            if (state is UserLoaded) {
              return [
                Settings(),
                Column(
                  children: [
                    const Text('Index 1: Business'),
                    Text('bloqueio biometrico: $biometricLockEnabled'),
                    Text('bloqueio biometrico: ${state.userEntity.email}'),
                  ],
                ),
                const Text('Index 2: School'),
              ][currentPageIndex];
            }
            return Container();
          }
          return Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.all(20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                backgroundColor: themeColors.colorScheme.primary,
              ),
              onPressed: _handleAuth,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  BestyTitle(title: 'Authenticate'),
                  SizedBox(width: 10),
                  Icon(
                    Icons.fingerprint,
                    size: 42,
                    color: themeColors.colorScheme.tertiary,
                  ),
                ],
              ),
            ),
            // : ElevatedButton(
            //   onPressed: _handleAuth,
            //   child: Row(
            //     mainAxisSize: MainAxisSize.min,
            //     children: <Widget>[
            //       Text(
            //         _isAuthenticating
            //             ? 'Cancel'
            //             : 'Authenticate: biometrics only',
            //       ),
            //       const Icon(Icons.fingerprint),
            //     ],
            //   ),
            // ),
          );
        },
      ),
    );
  }
}
