import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mcda_app/presentation/home/bloc/user_display_state.dart';

import '../../../domain/usecases/get_user.dart';

class UserDisplayCubit extends Cubit<UserDisplayState> {
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
}
