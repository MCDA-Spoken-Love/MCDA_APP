import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:mcda_app/domain/entities/user.dart';
import 'package:mcda_app/presentation/home/bloc/user_display_state.dart';

import '../../../domain/usecases/user/get_user.dart';

class UserDisplayCubit extends HydratedCubit<UserDisplayState> {
  UserDisplayCubit() : super(UserLoading());

  void displayUser() async {
    var result = await GetUserUseCase().call();
    result.fold(
      (error) {
        emit(LoadUserFailure(errorMessage: error));
      },
      (data) {
        emit(UserLoaded(userEntity: data));
      },
    );
  }

  @override
  UserDisplayState? fromJson(Map<String, dynamic> json) {
    print(json);

    switch (json['type']) {
      case 'UserLoaded':
        return UserLoaded(userEntity: UserEntity.fromJson(json['userEntity']));
      case 'LoadUserFailure':
        return LoadUserFailure(errorMessage: json['errorMessage']);
      case 'UserLoading':
      default:
        return UserLoading();
    }
  }

  @override
  Map<String, dynamic>? toJson(UserDisplayState state) {
    if (state is UserLoaded) {
      return {'type': 'UserLoaded', 'userEntity': state.userEntity.toJson()};
    } else if (state is LoadUserFailure) {
      return {'type': 'LoadUserFailure', 'errorMessage': state.errorMessage};
    } else if (state is UserLoading) {
      return {'type': 'UserLoading'};
    }
    return null;
  }
}
