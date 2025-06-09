import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mcda_app/common/widgets/routing/go_back/go_back.dart';
import 'package:mcda_app/common/widgets/text/sections_title.dart';
import 'package:mcda_app/core/configs/scaffold/scaffold_messenger_key.dart';
import 'package:mcda_app/domain/usecases/toggle_last_seen.dart';
import 'package:mcda_app/domain/usecases/toggle_status_visibility.dart';
import 'package:mcda_app/presentation/settings/pages/privacy/bloc/user_privacy_display_cubit.dart';
import 'package:mcda_app/presentation/settings/pages/privacy/bloc/user_privacy_display_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrivacyPage extends StatefulWidget {
  const PrivacyPage({super.key});

  @override
  State<PrivacyPage> createState() => _PrivacyPageState();
}

class _PrivacyPageState extends State<PrivacyPage> {
  bool? statusVisibilityEnabled = false;
  bool? lastSeenEnabled = false;
  bool? biometricLockEnabled;

  Future<Map<String, bool>> getPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return {"biometric_lock": prefs.getBool('biometric_lock') ?? false};
  }

  void setBiometricLock(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('biometric_lock', value);
    setState(() {
      biometricLockEnabled = value;
    });
  }

  @override
  void initState() {
    super.initState();
    getPrefs().then((res) {
      setState(() {
        biometricLockEnabled = res['biometric_lock'];
      });
    });
    final cubit = context.read<UserPrivacyDisplayCubit>();
    if (cubit.state is UserPrivacyLoading) {
      cubit.displayUserPrivacy();
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _handleToggleVisibility(bool value) async {
    ThemeData colors = Theme.of(context);

    var result = await ToggleStatusVisibilityUseCase().call();
    result.fold(
      (failure) {
        rootScaffoldMessengerKey.currentState?.showSnackBar(
          SnackBar(
            content: Text(failure),
            backgroundColor: colors.colorScheme.error,
          ),
        );
      },
      (success) => setState(() {
        statusVisibilityEnabled = value;
      }),
    );
  }

  void _handleToggleLastSeen(bool value) async {
    ThemeData colors = Theme.of(context);

    var result = await ToggleLastSeenUseCase().call();
    result.fold(
      (failure) {
        rootScaffoldMessengerKey.currentState?.showSnackBar(
          SnackBar(
            content: Text(failure),
            backgroundColor: colors.colorScheme.error,
          ),
        );
      },
      (success) => setState(() {
        lastSeenEnabled = value;
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GoBack(title: 'Privacy'),
      body: BlocListener<UserPrivacyDisplayCubit, UserPrivacyDisplayState>(
        listener: (context, state) {
          if (state is UserPrivacyLoaded) {
            setState(() {
              statusVisibilityEnabled =
                  state.userPrivacyEntity.allow_status_visibility;
              lastSeenEnabled = state.userPrivacyEntity.allow_last_seen;
            });
          }
        },
        child: BlocBuilder<UserPrivacyDisplayCubit, UserPrivacyDisplayState>(
          builder: (context, state) {
            if (state is UserPrivacyLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is LoadUserPrivacyFailure) {
              return Center(child: Text(state.errorMessage));
            }
            if (state is UserPrivacyLoaded) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SectionTitle('Visibility'),
                    SwitchListTile(
                      contentPadding: EdgeInsets.all(0),
                      title: Text('Allow my status to be visible'),
                      value: statusVisibilityEnabled ?? false,
                      onChanged: (bool value) => _handleToggleVisibility(value),
                    ),
                    SwitchListTile(
                      contentPadding: EdgeInsets.all(0),
                      title: Text('Allow last seen'),
                      subtitle: Text(
                        'When enabled, other users will be able to see when you were last online',
                      ),
                      value: lastSeenEnabled ?? false,
                      onChanged: (bool value) => _handleToggleLastSeen(value),
                    ),
                    SizedBox(height: 20),
                    SectionTitle('App lock'),
                    SwitchListTile(
                      isThreeLine: true,
                      contentPadding: EdgeInsets.all(0),
                      title: Text('Unlock with biometrics'),
                      subtitle: Text(
                        'When enabled, you’ll need to use fingerprint, face or other unique identifiers to open this app.',
                      ),
                      value: biometricLockEnabled ?? false,
                      onChanged: (bool value) {
                        setBiometricLock(value);
                      },
                    ),
                  ],
                ),
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
