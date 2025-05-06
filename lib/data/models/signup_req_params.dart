class SignupReqParams {
  final String email;
  final String username;
  final String first_name;
  final String last_name;
  final String password;
  final String? gender;
  final String? sexuality;
  final String connection_code;
  final bool? has_accepted_terms_and_conditions;
  final bool? has_accepted_privacy_policy;

  SignupReqParams({
    required this.first_name,
    required this.last_name,
    this.gender,
    this.sexuality,
    required this.connection_code,
    this.has_accepted_terms_and_conditions,
    this.has_accepted_privacy_policy,
    required this.email,
    required this.password,
    required this.username,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'password': password,
      'username': username,
      'first_name': first_name,
      'last_name': last_name,
      'gender': gender,
      'sexuality': sexuality,
      'connection_code': connection_code,
      'has_accepted_terms_and_conditions': has_accepted_terms_and_conditions,
      'has_accepted_privacy_policy': has_accepted_privacy_policy,
    };
  }
}
