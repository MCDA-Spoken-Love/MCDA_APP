import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mcda_app/common/blocs/valid_input/valid_input_state.dart';

import '../../../core/usecase/usecase.dart';

class ValidInputStateCubit extends Cubit<ValidInputState> {
  ValidInputStateCubit() : super(ValidInputInitialState());

  void execute({dynamic params, required UseCase usecase}) async {
    emit(ValidInputLoadingState());
    await Future.delayed(const Duration(seconds: 2));
    try {
      Either result = await usecase.call(param: params);
      result.fold(
        (error) {
          emit(InvalidInput(errorMessage: error.toString()));
        },
        (data) {
          emit(ValidatedInput(successMessage: data.toString()));
        },
      );
    } catch (e) {
      emit(InvalidInput(errorMessage: e.toString()));
    }
  }
}
