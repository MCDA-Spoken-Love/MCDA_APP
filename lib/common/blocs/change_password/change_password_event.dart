class ChangePasswordEvent {}

class ChangePasswordCallback extends ChangePasswordEvent {
  String new_password1;
  String new_password2;

  ChangePasswordCallback({
    required this.new_password1,
    required this.new_password2,
  });
}
