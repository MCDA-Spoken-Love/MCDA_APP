import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mcda_app/common/blocs/auth/auth_state_cubit.dart';
import 'package:mcda_app/common/widgets/button/besty_button.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../common/blocs/button/button_state_cubit.dart';
import '../../../core/provider/theme.dart';
import '../../../domain/entities/user.dart';
import '../../auth/pages/signin.dart';
import '../bloc/user_display_cubit.dart';
import '../bloc/user_display_state.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => UserDisplayCubit()..displayUser()),
          BlocProvider(create: (context) => ButtonStateCubit()),
          BlocProvider(create: (context) => AuthStateCubit()),
        ],
        child: Center(
          child: BlocBuilder<UserDisplayCubit, UserDisplayState>(
            builder: (context, state) {
              if (state is UserLoading) {
                return const CircularProgressIndicator();
              }
              if (state is UserLoaded) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Consumer(
                      builder:
                          (
                            context,
                            ThemeNotifier themeNotifier,
                            child,
                          ) => SwitchListTile(
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
                    _username(state.userEntity),
                    const SizedBox(height: 10),
                    _email(state.userEntity),
                    _logout(context),
                  ],
                );
              }
              if (state is LoadUserFailure) {
                return Text(state.errorMessage);
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }

  Widget _username(UserEntity user) {
    return Text(
      user.username,
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
    );
  }

  Widget _email(UserEntity user) {
    return Text(
      user.email,
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
    );
  }

  Widget _logout(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Consumer(
        builder: (context, ThemeNotifier themeNotifier, child) {
          return BestyButton(
            title: 'Logout',
            onPressed: () {
              SharedPreferences.getInstance().then((prefs) {
                prefs.remove('token');
              });
              themeNotifier.toggleColorScheme('main');
              themeNotifier.toggleColorTheme('light');

              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SigninPage()),
              );
            },
          );
        },
      ),
    );
  }
}
