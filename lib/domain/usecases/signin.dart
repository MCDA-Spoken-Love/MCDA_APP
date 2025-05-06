import 'package:dartz/dartz.dart';
import 'package:mcda_app/data/repository/auth.dart';

import '../../core/usecase/usecase.dart';
import '../../data/models/signin_req_params.dart';

class SigninUseCase implements UseCase<Either, SigninReqParams> {
  @override
  Future<Either> call({SigninReqParams? param}) async {
    return AuthRepositoryImpl().signin(param!);
  }
}
