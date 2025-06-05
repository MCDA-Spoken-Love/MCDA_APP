import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:mcda_app/core/network/dio_client.dart';
import 'package:mcda_app/data/models/signup_req_params.dart';

import '../models/signin_req_params.dart';

abstract class AuthApiService {
  Future<Either> signup(SignupReqParams signupReq);
  Future<Either> signin(SigninReqParams signinReq);
  Future<Either> getUser();
  dynamic getUserByFilter(String filter, String type);
}

class AuthApiServiceImpl extends AuthApiService {
  @override
  Future<Either> signup(SignupReqParams signupReq) async {
    try {
      var response = await DioClient().post(
        'api/auth/registration/',
        data: signupReq.toMap(),
      );
      return Right(response);
    } on DioException catch (e) {
      return Left(e.response);
    }
  }

  @override
  Future getUserByFilter(String filter, String type) async {
    try {
      if (type != 'username' && type != 'email') {
        return {"error": "Data provided should be username or email"};
      } else {
        var response = await DioClient().get('api/user/search/?$type=$filter');

        return response.data;
      }
    } on DioException catch (e) {
      return e.response;
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

  @override
  Future<Either> signin(SigninReqParams signinReq) async {
    try {
      var response = await DioClient().post(
        'api/auth/login/',
        data: signinReq.toMap(),
      );
      return Right(response);
    } on DioException catch (e) {
      return Left(e.response);
    }
  }
}
