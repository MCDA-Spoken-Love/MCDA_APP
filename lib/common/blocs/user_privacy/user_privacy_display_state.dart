import 'package:mcda_app/domain/entities/user_privacy.dart';

abstract class UserPrivacyDisplayState {}

class UserPrivacyInitial extends UserPrivacyDisplayState {}

class UserPrivacyLoading extends UserPrivacyDisplayState {}

class UserPrivacyLoaded extends UserPrivacyDisplayState {
  final UserPrivacyEntity userPrivacyEntity;

  UserPrivacyLoaded({required this.userPrivacyEntity});
}

class LoadUserPrivacyFailure extends UserPrivacyDisplayState {
  final String errorMessage;

  LoadUserPrivacyFailure({required this.errorMessage});
}
