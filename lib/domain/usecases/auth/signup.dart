import 'package:dartz/dartz.dart';
import 'package:mcda_app/data/models/signup_req_params.dart';
import 'package:mcda_app/data/repository/auth.dart';

import '../../../core/usecase/usecase.dart';

class SignupUseCase implements UseCase<Either, SignupReqParams> {
  @override
  Future<Either> call({SignupReqParams? param}) async {
    return AuthRepositoryImpl().signup(param!);
  }
}
