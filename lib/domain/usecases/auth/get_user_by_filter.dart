import 'package:dartz/dartz.dart';
import 'package:mcda_app/data/models/get_user_by_filter_params.dart';
import 'package:mcda_app/data/repository/auth.dart';

import '../../../core/usecase/usecase.dart';

class GetUserByFilterUseCase implements UseCase<Either, GetUserByFilterParams> {
  @override
  Future<Either> call({GetUserByFilterParams? param}) async {
    return AuthRepositoryImpl().getUserByFilter(param!);
  }
}
