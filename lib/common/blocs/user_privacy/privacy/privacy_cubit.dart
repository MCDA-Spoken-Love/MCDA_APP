import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:mcda_app/common/blocs/user_privacy/privacy/privacy_state.dart';

class PrivacyCubit extends HydratedCubit<PrivacyState> {
  PrivacyCubit()
    : super(
        PrivacyState(statusVisibilityEnabled: false, lastSeenEnabled: false),
      );

  void setStatusVisibility(bool value) {
    emit(state.copyWith(statusVisibilityEnabled: value));
  }

  void setLastSeen(bool value) => emit(state.copyWith(lastSeenEnabled: value));

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
