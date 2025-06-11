import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:mcda_app/core/network/dio_client.dart';
import 'package:mcda_app/data/models/change_password_req_params.dart';
import 'package:mcda_app/data/models/get_user_by_filter_params.dart';
import 'package:mcda_app/data/models/signup_req_params.dart';

import '../models/signin_req_params.dart';

abstract class AuthApiService {
  Future<Either> signup(SignupReqParams signupReq);
  Future<Either> signin(SigninReqParams signinReq);
  dynamic getUserByFilter(GetUserByFilterParams filterReq);
  Future<Either> changePassword(ChangePasswordReqParams changePasswordReq);
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
  Future<Either> changePassword(
    ChangePasswordReqParams changePasswordReq,
  ) async {
    try {
      var response = await DioClient().post(
        'api/auth/password/change/',
        data: changePasswordReq.toMap(),
      );
      return Right(response);
    } on DioException catch (e) {
      return Left(e.response);
    }
  }

  @override
  Future<Either> getUserByFilter(GetUserByFilterParams filterReq) async {
    Map<String, dynamic> filterMap = filterReq.toMap();
    try {
      if (filterMap['type'] != 'username' && filterMap['type'] != 'email') {
        return Left({"error": "Data provided should be username or email"});
      } else {
        var response = await DioClient().get(
          'api/user/search/?${filterMap['type']}=${filterMap['filter']}',
        );

        return Right(response);
      }
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
