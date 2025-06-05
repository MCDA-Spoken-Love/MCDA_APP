import 'package:dartz/dartz.dart';

abstract class PrivacyRepository {
  Future<Either> getUserPrivacy();
  Future<Either> toggleStatusVisibility();
  Future<Either> toggleLastSeen();
}
