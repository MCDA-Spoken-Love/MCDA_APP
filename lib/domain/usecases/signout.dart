import 'package:mcda_app/data/repository/auth.dart';

import '../../core/usecase/usecase.dart';

class SignoutUseCase extends UseCase<bool, dynamic> {
  @override
  Future<bool> call({param}) async {
    return await AuthRepositoryImpl().signout();
  }
}
