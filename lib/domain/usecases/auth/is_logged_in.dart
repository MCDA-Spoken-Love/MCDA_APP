import 'package:mcda_app/data/repository/auth.dart';

import '../../../core/usecase/usecase.dart';

class IsLoggedInUseCase implements UseCase<bool, dynamic> {
  @override
  Future<bool> call({dynamic param}) async {
    return AuthRepositoryImpl().isLoggedIn();
  }
}
