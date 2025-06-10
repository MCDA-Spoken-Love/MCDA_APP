import 'package:dartz/dartz.dart';
import 'package:mcda_app/core/usecase/usecase.dart';
import 'package:mcda_app/data/repository/privacy.dart';

class ToggleStatusVisibilityUseCase implements UseCase<Either, dynamic> {
  @override
  Future<Either> call({dynamic param}) async {
    return PrivacyRepositoryImpl().toggleStatusVisibility();
  }
}
