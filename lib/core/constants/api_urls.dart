import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiUrls {
  static var baseURL = dotenv.env["MCDA_API_SERVER"];
  static var register = '${baseURL}api/auth/register/';
  static var userProfile = '${baseURL}api/auth/user/';
  static var signin = '${baseURL}api/auth/login/';
  static var getUserByFilter = '${baseURL}api/user/search/';
}
