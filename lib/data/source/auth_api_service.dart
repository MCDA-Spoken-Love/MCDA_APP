import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:mcda_app/core/constants/api_urls.dart';
import 'package:mcda_app/core/network/dio_client.dart';
import 'package:mcda_app/data/models/signup_req_params.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/signin_req_params.dart';

abstract class AuthApiService {
  Future<Either> signup(SignupReqParams signupReq);

  Future<Either> signin(SigninReqParams signinReq);

  Future<Either> getUser();

  Future<Either> getUserByFilter(String filter, String type);
}

class AuthApiServiceImpl extends AuthApiService {
  @override
  Future<Either> signup(SignupReqParams signupReq) async {
    try {
      var response = await DioClient().post(
        ApiUrls.register,
        data: signupReq.toMap(),
      );
      return Right(response);
    } on DioException catch (e) {
      return Left(e.response);
    }
  }

  @override
  Future<Either> getUserByFilter(String filter, String type) async {
    try {
      if (type != 'username' && type != 'email') {
        return Right({"error": "Data provided should be username or email"});
      } else {
        var response = await DioClient().get(
          '${ApiUrls.getUserByFilter}?$type=$filter',
        );
        if (response.data['user_count'] > 0) {
          throw Exception('User found with $type $filter');
        }
        return Right(response);
      }
    } on DioException catch (e) {
      return Left(e.response);
    }
  }

  @override
  Future<Either> getUser() async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      var token = sharedPreferences.getString('token');
      var response = await DioClient().get(
        ApiUrls.userProfile,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
          },
        ),
      );
      return Right(response);
    } on DioException catch (e) {
      return Left(e.response);
    }
  }

  @override
  Future<Either> signin(SigninReqParams signinReq) async {
    try {
      var response = await DioClient().post(
        ApiUrls.signin,
        data: signinReq.toMap(),
      );
      return Right(response);
    } on DioException catch (e) {
      return Left(e.response);
    }
  }
}
