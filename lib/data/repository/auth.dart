import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:mcda_app/data/models/signin_req_params.dart';
import 'package:mcda_app/data/models/signup_req_params.dart';
import 'package:mcda_app/data/source/auth_api_service.dart';
import 'package:mcda_app/data/source/auth_local_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/repository/auth.dart';
import '../models/user.dart';

class AuthRepositoryImpl extends AuthRepository {
  @override
  Future<Either> signup(SignupReqParams signupReq) async {
    Either result = await AuthApiServiceImpl().signup(signupReq);
    return result.fold(
      (error) {
        return Left(error);
      },
      (data) async {
        Response response = data;
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        sharedPreferences.setString('token', response.data['token']);
        return Right(response);
      },
    );
  }

  @override
  Future<Either> getUser() async {
    Either result = await AuthApiServiceImpl().getUser();
    return result.fold(
      (error) {
        return Left(error);
      },
      (data) async {
        Response response = data;
        var userModel = UserModel.fromMap(response.data);
        var userEntity = userModel.toEntity();
        return Right(userEntity);
      },
    );
  }

  @override
  Future<bool> isLoggedIn() async {
    return await AuthLocalServiceImpl().isLoggedIn();
  }

  @override
  Future<Either> refresh() {
    // TODO: implement refresh
    throw UnimplementedError();
  }

  @override
  Future<Either> signin(SigninReqParams signinReq) async {
    Either result = await AuthApiServiceImpl().signin(signinReq);
    return result.fold(
      (error) {
        return Left(error);
      },
      (data) async {
        Response response = data;
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        sharedPreferences.setString('token', response.data['access']);
        return Right(response);
      },
    );
  }

  @override
  Future<Either> signout() async {
    return await AuthLocalServiceImpl().signout();
  }
}
