import 'package:dartz/dartz.dart';
import 'package:mcda_app/data/models/get_user_by_filter_params.dart';
import 'package:mcda_app/data/models/signup_req_params.dart';

import '../../data/models/signin_req_params.dart';

abstract class AuthRepository {
  Future<Either> signup(SignupReqParams signupReq);

  Future<Either> signin(SigninReqParams signinReq);

  Future<Either> signout();

  Future<bool> isLoggedIn();

  Future<Either> getUser();

  Future<Either> refresh();

  Future<Either> getUserByFilter(GetUserByFilterParams filterReq);
}
