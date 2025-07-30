import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:mcda_app/common/utils/map_to_string.dart';
import 'package:mcda_app/data/models/user.dart';
import 'package:mcda_app/data/source/user_api_service.dart';
import 'package:mcda_app/domain/repository/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

Logger logger = Logger(
  printer: PrettyPrinter(methodCount: 0, colors: true, printEmojis: true),
);

class UserRepositoryImpl extends UserRepository {
  @override
  Future<Either> deleteAccount() async {
    Either result = await UserApiServiceImpl().deleteAccount();
    return result.fold(
      (error) {
        return Left(mapToString(error.data));
      },
      (data) async {
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        sharedPreferences.remove('token');
        sharedPreferences.remove('theme');
        sharedPreferences.remove('scheme');
        return Right(data);
      },
    );
  }

  @override
  Future<Either> getUser() async {
    Either result = await UserApiServiceImpl().getUser();
    return result.fold(
      (error) {
        return Left(mapToString(error.data));
      },
      (data) async {
        Response response = data;
        var userModel = UserModel.fromMap(response.data);
        var userEntity = userModel.toEntity();
        return Right(userEntity);
      },
    );
  }
}
