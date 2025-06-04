import 'package:mcda_app/domain/entities/user_privacy.dart';

abstract class UserPrivacyDisplayState {}

class UserPrivacyLoading extends UserPrivacyDisplayState {}

class UserPrivacyLoaded extends UserPrivacyDisplayState {
  final UserPrivacyEntity userPrivacyEntity;

  UserPrivacyLoaded({required this.userPrivacyEntity});
}

class LoadUserFailure extends UserPrivacyDisplayState {
  final String errorMessage;

  LoadUserFailure({required this.errorMessage});
}
