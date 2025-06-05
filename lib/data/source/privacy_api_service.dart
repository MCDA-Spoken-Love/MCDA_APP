import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:mcda_app/core/network/dio_client.dart';

abstract class PrivacyApiService {
  Future<Either> getUserPrivacy();
  Future<Either> toggleStatusVisibility();
  Future<Either> toggleLastSeen();
}

class PrivacyApiServiceImpl extends PrivacyApiService {
  @override
  Future<Either> getUserPrivacy() async {
    try {
      var response = await DioClient().get('api/privacy/');
      return Right(response);
    } on DioException catch (e) {
      return Left(e.response);
    }
  }

  @override
  Future<Either> toggleStatusVisibility() async {
    try {
      var response = await DioClient().put('api/privacy/toggle/status/');
      return Right(response);
    } on DioException catch (e) {
      return Left(e.response);
    }
  }

  @override
  Future<Either> toggleLastSeen() async {
    try {
      var response = await DioClient().put('api/privacy/toggle/last_seen/');
      return Right(response);
    } on DioException catch (e) {
      return Left(e.response);
    }
  }
}
