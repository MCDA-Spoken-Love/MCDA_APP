import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mcda_app/common/blocs/biometric_lock/biometric_lock_bloc.dart';
import 'package:mcda_app/common/blocs/biometric_lock/biometric_lock_event.dart';
import 'package:mcda_app/common/blocs/biometric_lock/biometric_lock_state.dart';
import 'package:mcda_app/common/blocs/user_privacy/user_privacy_display_cubit.dart';
import 'package:mcda_app/common/blocs/user_privacy/user_privacy_display_state.dart';
import 'package:mcda_app/common/widgets/custom_scaffold/custom_scaffold.dart';
import 'package:mcda_app/common/widgets/routing/navbar/navbar.dart';
import 'package:mcda_app/common/widgets/text/besty_title.dart';
import 'package:mcda_app/presentation/settings/settings.dart';

import '../../common/blocs/user/user_display_cubit.dart';
import '../../common/blocs/user/user_display_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPageIndex = 1;

  @override
  void initState() {
    super.initState();

    final cubit = context.read<UserDisplayCubit>();
    if (cubit.state is UserLoading) {
      cubit.displayUser();
    }
    final privacyCubit = context.read<UserPrivacyDisplayCubit>();
    if (privacyCubit.state is! UserPrivacyLoaded) {
      privacyCubit.displayUserPrivacy();
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

    return BlocProvider(
      create: (_) => BiometricLockBloc()..add(BiometricLockCallback()),
      child: BlocBuilder<BiometricLockBloc, BiometricLockState>(
        builder: (context, bioLockState) {
          if (bioLockState is BiometricLockInitial) {
            return Container(
              color: themeColors.scaffoldBackgroundColor,
              child: Center(child: CircularProgressIndicator()),
            );
          }
          if (bioLockState is BioLockUnauthenticated) {
            return Container(
              color: themeColors.scaffoldBackgroundColor,
              child: Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    backgroundColor: themeColors.colorScheme.primary,
                  ),
                  onPressed:
                      () => BlocProvider.of<BiometricLockBloc>(
                        context,
                      ).add(BiometricLockCallback()),
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
              ),
            );
          }
          return Scaffold(
            extendBody: true,
            bottomNavigationBar: Navbar(
              onItemTapped: _onItemTapped,
              currentPageIndex: currentPageIndex,
            ),
            body: BlocBuilder<BiometricLockBloc, BiometricLockState>(
              builder: (context, bioLockState) {
                return BlocBuilder<UserDisplayCubit, UserDisplayState>(
                  builder: (context, state) {
                    if (state is UserLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (state is LoadUserFailure) {
                      return Center(child: Text(state.errorMessage));
                    }
                    if (state is UserLoaded) {
                      return [
                        BlocBuilder<
                          UserPrivacyDisplayCubit,
                          UserPrivacyDisplayState
                        >(
                          builder: (context, state) {
                            return Settings();
                          },
                        ),
                        CustomScaffold.withChild(
                          appBar: Text(
                            'Relationship',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          body: Column(
                            children: [
                              const Text('Index 1: Business'),

                              Text(
                                'bloqueio biometrico: ${state.userEntity.email}',
                              ),
                            ],
                          ),
                        ),
                        CustomScaffold.withChild(
                          appBar: Text(
                            'Account',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          body: Column(
                            children: [
                              const Text('Index 1: Business'),

                              Text(
                                'bloqueio biometrico: ${state.userEntity.email}',
                              ),
                            ],
                          ),
                        ),
                      ][currentPageIndex];
                    }
                    return Container();
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}
