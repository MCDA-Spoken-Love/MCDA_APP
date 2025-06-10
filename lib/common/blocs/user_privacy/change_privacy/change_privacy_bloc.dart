import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mcda_app/common/blocs/user_privacy/change_privacy/change_privacy_event.dart';
import 'package:mcda_app/common/blocs/user_privacy/change_privacy/change_privacy_state.dart';
import 'package:mcda_app/domain/usecases/privacy/toggle_last_seen.dart';
import 'package:mcda_app/domain/usecases/privacy/toggle_status_visibility.dart';

class ChangePrivacyBloc extends Bloc<ChangePrivacyEvent, ChangePrivacyState> {
  ChangePrivacyBloc() : super(ChangePrivacyInitialState()) {
    on<ChangeStatusVisibilitySetting>((event, emit) async {
      emit(ChangePrivacyLoading());
      final res = await ToggleStatusVisibilityUseCase().call();
      res.fold(
        (failure) {
          emit(ChangePrivacyFailure(message: failure));
          return Left(failure);
        },
        (success) {
          event.onSuccess();
          emit(ChangedPrivacySetting());
          return Right(success);
        },
      );
    });

    on<ChangeLastSeenSetting>((event, emit) async {
      emit(ChangePrivacyLoading());
      final res = await ToggleLastSeenUseCase().call();
      res.fold(
        (failure) {
          emit(ChangePrivacyFailure(message: failure));
          return Left(failure);
        },
        (success) {
          event.onSuccess();
          emit(ChangedPrivacySetting());
          return Right(success);
        },
      );
    });
  }
}
