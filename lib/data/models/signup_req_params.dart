class SignupReqParams {
  final String email;
  final String username;
  final String first_name;
  final String last_name;
  final String password1;
  final String password2;
  final String? gender;
  final String? sexuality;
  final bool? has_accepted_terms_and_conditions;
  final bool? has_accepted_privacy_policy;

  SignupReqParams({
    required this.first_name,
    required this.last_name,
    this.gender,
    this.sexuality,
    this.has_accepted_terms_and_conditions,
    this.has_accepted_privacy_policy,
    required this.email,
    required this.password1,
    required this.password2,
    required this.username,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'password1': password1,
      'password2': password2,
      'username': username,
      'first_name': first_name,
      'last_name': last_name,
      'gender': gender,
      'sexuality': sexuality,
      'has_accepted_terms_and_conditions': has_accepted_terms_and_conditions,
      'has_accepted_privacy_policy': has_accepted_privacy_policy,
    };
  }
}
