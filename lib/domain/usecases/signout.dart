import 'package:dartz/dartz.dart';
import 'package:mcda_app/data/repository/auth.dart';

import '../../core/usecase/usecase.dart';

class SignoutUseCase extends UseCase<Either, dynamic> {
  @override
  Future<Either> call({param}) async {
    return await AuthRepositoryImpl().signout();
  }
}
