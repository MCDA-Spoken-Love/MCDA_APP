import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mcda_app/domain/usecases/get_user_privacy.dart';
import 'package:mcda_app/presentation/settings/pages/privacy/bloc/user_privacy_display_state.dart';

class UserPrivacyDisplayCubit extends Cubit<UserPrivacyDisplayState> {
  UserPrivacyDisplayCubit() : super(UserPrivacyLoading());

  void displayUserPrivacy() async {
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
}
