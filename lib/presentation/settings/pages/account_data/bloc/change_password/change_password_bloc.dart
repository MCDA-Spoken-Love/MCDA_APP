import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mcda_app/data/models/change_password_req_params.dart';
import 'package:mcda_app/domain/usecases/auth/change_password.dart';
import 'package:mcda_app/presentation/settings/pages/account_data/bloc/change_password/change_password_event.dart';
import 'package:mcda_app/presentation/settings/pages/account_data/bloc/change_password/change_password_state.dart';

class ChangePasswordBloc
    extends Bloc<ChangePasswordEvent, ChangePasswordState> {
  ChangePasswordBloc() : super(ChangePasswordInitial()) {
    on<ChangePasswordCallback>((event, emit) async {
      emit(ChangePasswordLoading());
      final res = await ChangePasswordUseCase().call(
        param: ChangePasswordReqParams(
          new_password1: event.new_password1,
          new_password2: event.new_password2,
        ),
      );
      res.fold(
        (failure) {
          emit(ChangePasswordFailure(message: failure));
          return Left(failure);
        },
        (success) {
          emit(PasswordChanged(message: success['detail']));
          return Right(success);
        },
      );
    });
  }
}
