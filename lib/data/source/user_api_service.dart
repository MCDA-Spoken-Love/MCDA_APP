import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:mcda_app/core/network/dio_client.dart';

abstract class UserApiService {
  Future<Either> terminateRelationship();
  Future<Either> deleteAccount();
  Future<Either> getUser();
}

class UserApiServiceImpl extends UserApiService {
  @override
  Future<Either> terminateRelationship() async {
    try {
      var response = await DioClient().delete('api/user/relationship/');
      return Right(response);
    } on DioException catch (e) {
      return Left(e.response);
    }
  }

  @override
  Future<Either> deleteAccount() async {
    try {
      var response = await DioClient().delete('api/user/');
      return Right(response);
    } on DioException catch (e) {
      return Left(e.response);
    }
  }

  @override
  Future<Either> getUser() async {
    try {
      var response = await DioClient().get('api/auth/user/');
      return Right(response);
    } on DioException catch (e) {
      return Left(e.response);
    }
  }
}
