import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mcda_app/common/blocs/auth/auth_state_cubit.dart';
import 'package:mcda_app/common/blocs/button/button_state_cubit.dart';
import 'package:mcda_app/common/widgets/button/besty_button.dart';
import 'package:mcda_app/common/widgets/navbar/navbar.dart';
import 'package:mcda_app/core/provider/theme.dart';
import 'package:mcda_app/domain/usecases/signout.dart';
import 'package:mcda_app/presentation/auth/pages/signin.dart';
import 'package:mcda_app/presentation/home/bloc/user_display_cubit.dart';
import 'package:mcda_app/presentation/home/bloc/user_display_state.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:provider/provider.dart';

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
  final List<ScrollController> _scrollControllers = [
    ScrollController(),
    ScrollController(),
  ];

  List<PersistentBottomNavBarItem> _navBarsItems(ThemeData theme) => [
    PersistentBottomNavBarItem(
      title: "Settings",
      icon: const Icon(Icons.settings),
      inactiveIcon: const Icon(Icons.settings_outlined),
      activeColorPrimary: theme.highlightColor,
      activeColorSecondary: theme.colorScheme.onPrimary,
      inactiveColorPrimary: theme.canvasColor,
      inactiveColorSecondary: theme.canvasColor,
      scrollController: _scrollControllers.first,
    ),
    PersistentBottomNavBarItem(
      title: "Chat",
      icon: const Icon(Icons.favorite),
      inactiveIcon: const Icon(Icons.favorite_border_outlined),
      activeColorPrimary: theme.highlightColor,
      activeColorSecondary: theme.colorScheme.onPrimary,
      inactiveColorPrimary: theme.canvasColor,
      inactiveColorSecondary: theme.canvasColor,
    ),

    PersistentBottomNavBarItem(
      title: "Settings",
      icon: const Icon(Icons.account_circle),
      inactiveIcon: const Icon(Icons.account_circle_outlined),
      activeColorPrimary: theme.highlightColor,
      activeColorSecondary: theme.colorScheme.onPrimary,
      inactiveColorPrimary: theme.canvasColor,
      inactiveColorSecondary: theme.canvasColor,
      scrollController: _scrollControllers.last,
    ),
  ];

  List<Widget> _buildScreens(state) => [
    Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Consumer(
            builder:
                (context, ThemeNotifier themeNotifier, child) => SwitchListTile(
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
                      heroTag: 'appColorSchemeDynamic',
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
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
          ),
          Padding(
            padding: const EdgeInsets.all(32),
            child: Consumer(
              builder: (context, ThemeNotifier themeNotifier, child) {
                return BestyButton(
                  title: 'Logout',
                  onPressed: () {
                    themeNotifier.toggleColorScheme('main');
                    if (themeNotifier.theme == 'dark') {
                      themeNotifier.toggleTheme();
                    }
                    context.read<ButtonStateCubit>().execute(
                      usecase: SignoutUseCase(),
                    );
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => SigninPage()),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    ),
    const Text('Index 1: Business', style: optionStyle),
    const Text('Index 2: School', style: optionStyle),
  ];

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return MultiBlocProvider(
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
            return Navbar(
              buildScreens: _buildScreens(state),
              navBarsItems: _navBarsItems(theme),
            );
          }
          return Container();
        },
      ),
    );
  }
}
