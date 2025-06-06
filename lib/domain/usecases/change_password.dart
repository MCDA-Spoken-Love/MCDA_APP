import 'package:dartz/dartz.dart';
import 'package:mcda_app/data/models/change_password_req_params.dart';
import 'package:mcda_app/data/repository/auth.dart';

import '../../core/usecase/usecase.dart';

class ChangePasswordUseCase
    implements UseCase<Either, ChangePasswordReqParams> {
  @override
  Future<Either> call({ChangePasswordReqParams? param}) async {
    return AuthRepositoryImpl().changePassword(param!);
  }
}
