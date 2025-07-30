import 'package:dartz/dartz.dart';

abstract class UserRepository {
  Future<Either> deleteAccount();
  Future<Either> getUser();
}
