abstract class ChangePasswordState {}

class ChangePasswordInitial extends ChangePasswordState {}

class ChangePasswordLoading extends ChangePasswordState {}

class PasswordChanged extends ChangePasswordState {
  final String message;

  PasswordChanged({required this.message});
}

class ChangePasswordFailure extends ChangePasswordState {
  final String message;

  ChangePasswordFailure({required this.message});
}
