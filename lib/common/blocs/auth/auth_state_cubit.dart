import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mcda_app/domain/usecases/auth/is_logged_in.dart';

import 'auth_state.dart';

class AuthStateCubit extends Cubit<AuthState> {
  AuthStateCubit() : super(AppInitialState());

  void appStarted() async {
    var isLoggedIn = await IsLoggedInUseCase().call();
    if (isLoggedIn) {
      emit(Authenticated());
    } else if (isLoggedIn == false) {
      emit(Unauthenticated());
    }
  }
}
