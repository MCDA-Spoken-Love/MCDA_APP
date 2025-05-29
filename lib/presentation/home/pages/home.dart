import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mcda_app/common/blocs/auth/auth_state_cubit.dart';
import 'package:mcda_app/common/widgets/routing/navbar/navbar.dart';
import 'package:mcda_app/presentation/settings/settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../common/blocs/button/button_state_cubit.dart';
import '../bloc/user_display_cubit.dart';
import '../bloc/user_display_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const TextStyle optionStyle = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.bold,
  );
  int currentPageIndex = 1;

  bool? biometricLockEnabled;

  Future<Map<String, bool>> getPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return {"biometric_lock": prefs.getBool('biometric_lock') ?? false};
  }

  @override
  void initState() {
    super.initState();
    getPrefs().then((res) {
      setState(() {
        biometricLockEnabled = res['biometric_lock'];
      });
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      currentPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    print('biometrick lock: $biometricLockEnabled');
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: Navbar(
        onItemTapped: _onItemTapped,
        currentPageIndex: currentPageIndex,
      ),

      body: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => UserDisplayCubit()..displayUser()),
          BlocProvider(create: (context) => ButtonStateCubit()),
          BlocProvider(create: (context) => AuthStateCubit()),
        ],
        child: BlocBuilder<UserDisplayCubit, UserDisplayState>(
          builder: (context, state) {
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
                    const Text('Index 1: Business', style: optionStyle),
                    Text(
                      'bloqueio biometrico: $biometricLockEnabled',
                      style: optionStyle,
                    ),
                  ],
                ),
                const Text('Index 2: School', style: optionStyle),
              ][currentPageIndex];
            }
            return Container();
          },
        ),
      ),
    );
  }
}
