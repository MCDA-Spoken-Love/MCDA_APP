import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mcda_app/common/blocs/delete_account/delete_account_event.dart';
import 'package:mcda_app/common/blocs/delete_account/delete_account_state.dart';
import 'package:mcda_app/domain/usecases/user/delete_account.dart';

class DeleteAccountBloc extends Bloc<DeleteAccountEvent, DeleteAccountState> {
  DeleteAccountBloc() : super(DeleteAccountInitialState()) {
    on<DeleteAccountCallback>((event, emit) async {
      emit(DeleteAccountLoading());
      final res = await DeleteAccountUseCase().call();
      res.fold(
        (failure) {
          emit(DeleteAccountFailure(message: failure));
          return Left(failure);
        },
        (success) {
          emit(AccountDeleted(message: success['message']));
          return Right(success);
        },
      );
    });
  }
}
