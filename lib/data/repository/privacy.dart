import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:mcda_app/data/models/privacy.dart';
import 'package:mcda_app/domain/repository/privacy.dart';

class PrivacyRepositoryImpl extends PrivacyRepository {
  @override
  Future<Either> getUserPrivacy() async {
    Either result = await PrivacyRepositoryImpl().getUserPrivacy();
    return result.fold(
      (error) {
        return Left(error);
      },
      (data) async {
        Response response = data;
        var userPrivacyModel = UserPrivacyModel.fromMap(response.data);
        var userPrivacyEntity = userPrivacyModel.toEntity();
        return Right(userPrivacyEntity);
      },
    );
  }

  @override
  Future<Either> toggleLastSeen() async {
    Either result = await PrivacyRepositoryImpl().toggleLastSeen();
    return result.fold(
      (error) {
        return Left(error);
      },
      (data) async {
        Response response = data;
        var userPrivacyModel = UserPrivacyModel.fromMap(response.data);
        var userPrivacyEntity = userPrivacyModel.toEntity();
        return Right(userPrivacyEntity);
      },
    );
  }

  @override
  Future<Either> toggleStatusVisibility() async {
    Either result = await PrivacyRepositoryImpl().toggleStatusVisibility();
    return result.fold(
      (error) {
        return Left(error);
      },
      (data) async {
        Response response = data;
        var userPrivacyModel = UserPrivacyModel.fromMap(response.data);
        var userPrivacyEntity = userPrivacyModel.toEntity();
        return Right(userPrivacyEntity);
      },
    );
  }
}
