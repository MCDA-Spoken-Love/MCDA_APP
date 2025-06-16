import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mcda_app/common/blocs/user_privacy/change_privacy/change_privacy_bloc.dart';
import 'package:mcda_app/common/blocs/user_privacy/change_privacy/change_privacy_event.dart';
import 'package:mcda_app/common/blocs/user_privacy/change_privacy/change_privacy_state.dart';
import 'package:mcda_app/common/blocs/user_privacy/privacy/privacy_cubit.dart';
import 'package:mcda_app/common/blocs/user_privacy/privacy/privacy_state.dart';
import 'package:mcda_app/common/blocs/user_privacy/user_privacy_display_cubit.dart';
import 'package:mcda_app/common/blocs/user_privacy/user_privacy_display_state.dart';
import 'package:mcda_app/common/widgets/routing/go_back/go_back.dart';
import 'package:mcda_app/common/widgets/text/snackbar.dart';
import 'package:mcda_app/common/widgets/text/sections_title.dart';

class PrivacyPage extends StatefulWidget {
  const PrivacyPage({super.key});

  @override
  State<PrivacyPage> createState() => _PrivacyPageState();
}

class _PrivacyPageState extends State<PrivacyPage> {
  bool _synced = false;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GoBack(title: 'Privacy'),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => PrivacyCubit()),
          BlocProvider(create: (context) => ChangePrivacyBloc()),
        ],
        child: MultiBlocListener(
          listeners: [
            BlocListener<UserPrivacyDisplayCubit, UserPrivacyDisplayState>(
              listener: (BuildContext context, UserPrivacyDisplayState state) {
                if (state is UserPrivacyLoaded) {
                  context.read<PrivacyCubit>().setStatusVisibility(
                    state.userPrivacyEntity.allow_status_visibility,
                  );
                  context.read<PrivacyCubit>().setLastSeen(
                    state.userPrivacyEntity.allow_last_seen,
                  );
                }
              },
            ),
            BlocListener<ChangePrivacyBloc, ChangePrivacyState>(
              listener: (BuildContext context, ChangePrivacyState state) {
                if (state is ChangePrivacyFailure) {
                  GlobalSnackBar.show(context, state.message, status: 'error');
                }
              },
            ),
          ],
          child: BlocBuilder<UserPrivacyDisplayCubit, UserPrivacyDisplayState>(
            builder: (BuildContext context, UserPrivacyDisplayState state) {
              if (state is UserPrivacyLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is LoadUserPrivacyFailure) {
                return Center(child: Text(state.errorMessage));
              }
              if (state is UserPrivacyLoaded) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: BlocBuilder<PrivacyCubit, PrivacyState>(
                    builder: (BuildContext context, PrivacyState privacyState) {
                      return BlocBuilder<ChangePrivacyBloc, ChangePrivacyState>(
                        builder: (
                          BuildContext context,
                          ChangePrivacyState changePrivacyState,
                        ) {
                          final userPrivacyState =
                              context.watch<UserPrivacyDisplayCubit>().state;

                          if (!_synced &&
                              userPrivacyState is UserPrivacyLoaded) {
                            context.read<PrivacyCubit>().setStatusVisibility(
                              userPrivacyState
                                  .userPrivacyEntity
                                  .allow_status_visibility,
                            );
                            context.read<PrivacyCubit>().setLastSeen(
                              userPrivacyState
                                  .userPrivacyEntity
                                  .allow_last_seen,
                            );
                            _synced = true;
                          }

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SectionTitle('Visibility'),
                              SwitchListTile(
                                contentPadding: EdgeInsets.all(0),
                                title: Text('Allow my status to be visible'),
                                value: privacyState.statusVisibilityEnabled,
                                onChanged: (bool value) {
                                  context
                                      .read<PrivacyCubit>()
                                      .setStatusVisibility(value);

                                  BlocProvider.of<ChangePrivacyBloc>(
                                    context,
                                  ).add(
                                    ChangeStatusVisibilitySetting(
                                      onSuccess: () {
                                        context
                                            .read<UserPrivacyDisplayCubit>()
                                            .displayUserPrivacy();
                                      },
                                    ),
                                  );
                                },
                              ),
                              SwitchListTile(
                                contentPadding: EdgeInsets.all(0),
                                title: Text('Allow last seen'),
                                subtitle: Text(
                                  'When enabled, other users will be able to see when you were last online',
                                ),
                                value: privacyState.lastSeenEnabled,
                                onChanged: (bool value) {
                                  context.read<PrivacyCubit>().setLastSeen(
                                    value,
                                  );
                                  BlocProvider.of<ChangePrivacyBloc>(
                                    context,
                                  ).add(
                                    ChangeLastSeenSetting(
                                      onSuccess: () {
                                        context
                                            .read<UserPrivacyDisplayCubit>()
                                            .displayUserPrivacy();
                                      },
                                    ),
                                  );
                                },
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
                                value: privacyState.biometricLockEnabled,
                                onChanged: (bool value) {
                                  context
                                      .read<PrivacyCubit>()
                                      .updateBiometricLock(value);
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                );
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ),
    );
  }
}
