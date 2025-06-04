import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthLocalService {
  Future<bool> isLoggedIn();
  Future<Either> signout();
}

class AuthLocalServiceImpl extends AuthLocalService {
  @override
  Future<bool> isLoggedIn() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.getString('token');
    if (token != null) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<Either> signout() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove('token');
    return Right(true);
  }
}
