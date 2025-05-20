import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mcda_app/common/blocs/auth/auth_state_cubit.dart';
import 'package:mcda_app/common/widgets/button/besty_button.dart';
import 'package:mcda_app/common/widgets/navbar/navbar.dart';
import 'package:mcda_app/domain/usecases/signout.dart';
import 'package:provider/provider.dart';

import '../../../common/blocs/button/button_state_cubit.dart';
import '../../../core/provider/theme.dart';
import '../../auth/pages/signin.dart';
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

  void _onItemTapped(int index) {
    setState(() {
      currentPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,

      body: Center(
        child:
            <Widget>[
              MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (context) => UserDisplayCubit()..displayUser(),
                  ),
                  BlocProvider(create: (context) => ButtonStateCubit()),
                  BlocProvider(create: (context) => AuthStateCubit()),
                ],
                child: MultiBlocProvider(
                  providers: [
                    BlocProvider(
                      create: (context) => UserDisplayCubit()..displayUser(),
                    ),
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
                                      value:
                                          themeNotifier.theme == 'dark'
                                              ? true
                                              : false,
                                    ),
                              ),
                              Consumer(
                                builder:
                                    (
                                      context,
                                      ThemeNotifier themeNotifier,
                                      child,
                                    ) => FloatingActionButton(
                                      heroTag: 'appColorSchemeDynamic',
                                      onPressed: () {
                                        themeNotifier.toggleColorScheme(
                                          'dynamic',
                                        );
                                      },
                                      child: Icon(Icons.add),
                                    ),
                              ),
                              Consumer(
                                builder:
                                    (
                                      context,
                                      ThemeNotifier themeNotifier,
                                      child,
                                    ) => FloatingActionButton(
                                      heroTag: 'appColorSchemeMain',
                                      onPressed: () {
                                        themeNotifier.toggleColorScheme('main');
                                      },
                                      child: Icon(Icons.add),
                                    ),
                              ),

                              const SizedBox(height: 10),
                              Text(
                                state.userEntity.email,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 19,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(32),
                                child: Consumer(
                                  builder: (
                                    context,
                                    ThemeNotifier themeNotifier,
                                    child,
                                  ) {
                                    return BestyButton(
                                      title: 'Logout',
                                      onPressed: () {
                                        themeNotifier.toggleColorScheme('main');
                                        if (themeNotifier.theme == 'dark') {
                                          themeNotifier.toggleTheme();
                                        }
                                        context
                                            .read<ButtonStateCubit>()
                                            .execute(usecase: SignoutUseCase());
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) => SigninPage(),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),
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
              ),
              const Text('Index 1: Business', style: optionStyle),
              const Text('Index 2: School', style: optionStyle),
            ][currentPageIndex],
      ),
      bottomNavigationBar: Navbar(
        onItemTapped: _onItemTapped,
        currentPageIndex: currentPageIndex,
      ),
    );
  }
}
