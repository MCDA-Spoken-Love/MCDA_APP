class ChangePasswordReqParams {
  final String new_password1;
  final String new_password2;

  ChangePasswordReqParams({
    required this.new_password1,
    required this.new_password2,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'new_password1': new_password1,
      'new_password2': new_password2,
    };
  }
}
