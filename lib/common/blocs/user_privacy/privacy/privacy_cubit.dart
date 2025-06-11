import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:mcda_app/common/blocs/user_privacy/privacy/privacy_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrivacyCubit extends HydratedCubit<PrivacyState> {
  PrivacyCubit()
    : super(
        PrivacyState(
          statusVisibilityEnabled: false,
          lastSeenEnabled: false,
          biometricLockEnabled: false,
        ),
      );

  void setStatusVisibility(bool value) =>
      emit(state.copyWith(statusVisibilityEnabled: value));

  void setLastSeen(bool value) => emit(state.copyWith(lastSeenEnabled: value));

  void setBiometricLock(bool value) =>
      emit(state.copyWith(biometricLockEnabled: value));

  void initializeBiometricLock() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setBiometricLock(prefs.getBool('biometric_lock') ?? false);
  }

  void updateBiometricLock(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('biometric_lock', value);
    setBiometricLock(value);
  }

  @override
  PrivacyState? fromJson(Map<String, dynamic> json) {
    try {
      return PrivacyState.fromMap(json);
    } catch (_) {
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(PrivacyState state) {
    return state.toMap();
  }
}
