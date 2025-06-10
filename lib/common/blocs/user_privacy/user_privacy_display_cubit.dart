import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:mcda_app/common/blocs/user_privacy/user_privacy_display_state.dart';
import 'package:mcda_app/domain/entities/user_privacy.dart';
import 'package:mcda_app/domain/usecases/privacy/get_user_privacy.dart';

class UserPrivacyDisplayCubit extends HydratedCubit<UserPrivacyDisplayState> {
  UserPrivacyDisplayCubit() : super(UserPrivacyInitial());

  void displayUserPrivacy() async {
    emit(UserPrivacyLoading());
    var result = await GetUserPrivacyUseCase().call();
    result.fold(
      (error) {
        emit(LoadUserPrivacyFailure(errorMessage: error));
      },
      (data) {
        emit(UserPrivacyLoaded(userPrivacyEntity: data));
      },
    );
  }

  @override
  UserPrivacyDisplayState? fromJson(Map<String, dynamic> json) {
    switch (json['type']) {
      case 'UserPrivacyLoaded':
        return UserPrivacyLoaded(
          userPrivacyEntity: UserPrivacyEntity.fromJson(
            json['userPrivacyEntity'],
          ),
        );
      case 'LoadUserPrivacyFailure':
        return LoadUserPrivacyFailure(errorMessage: json['errorMessage']);
      case 'UserPrivacyLoading':
      default:
        return UserPrivacyLoading();
    }
  }

  @override
  Map<String, dynamic>? toJson(UserPrivacyDisplayState state) {
    if (state is UserPrivacyLoaded) {
      return {
        'type': 'UserPrivacyLoaded',
        'userPrivacyEntity': state.userPrivacyEntity.toJson(),
      };
    } else if (state is LoadUserPrivacyFailure) {
      return {
        'type': 'LoadUserPrivacyFailure',
        'errorMessage': state.errorMessage,
      };
    } else if (state is UserPrivacyLoading) {
      return {'type': 'UserPrivacyLoading'};
    }
    return null;
  }
}
