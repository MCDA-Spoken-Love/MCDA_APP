import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:mcda_app/core/network/dio_client.dart';

abstract class RelationshipApiService {
  Future<Either> getRelationship();
  Future<Either> terminateRelationship();
}

class RelationshipApiServiceImpl extends RelationshipApiService {
  @override
  Future<Either> getRelationship() async {
    try {
      var response = await DioClient().get('api/relationship');
      return Right(response);
    } on DioException catch (e) {
      return Left(e.response);
    }
  }

  @override
  Future<Either> terminateRelationship() async {
    try {
      var response = await DioClient().delete('api/relationship/');
      return Right(response);
    } on DioException catch (e) {
      return Left(e.response);
    }
  }
}
