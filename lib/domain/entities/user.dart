class UserEntity {
  final int id;
  final String email;
  final String username;
  final String first_name;
  final String last_name;
  final String password;
  final String? gender;
  final String? sexuality;
  final String connection_code;
  final int? partner_id;
  final String? relation_ship_start_date;
  final bool? has_accepted_terms_and_conditions;
  final bool? has_accepted_privacy_policy;

  UserEntity({
    this.gender,
    this.sexuality,
    this.partner_id,
    this.relation_ship_start_date,
    this.has_accepted_terms_and_conditions,
    this.has_accepted_privacy_policy,
    required this.first_name,
    required this.last_name,
    required this.id,
    required this.password,
    required this.connection_code,
    required this.email,
    required this.username,
  });

  factory UserEntity.fromJson(Map<String, dynamic> json) {
    return UserEntity(
      id: json['id'],
      first_name: json['first_name'],
      last_name: json['last_name'],
      password: json['password'],
      connection_code: json['connection_code'],
      email: json['email'],
      username: json['username'],
      gender: json['gender'],
      sexuality: json['sexuality'],
      partner_id: json['partner_id'],
      relation_ship_start_date: json['relation_ship_start_date'],
      has_accepted_terms_and_conditions:
          json['has_accepted_terms_and_conditions'],
      has_accepted_privacy_policy: json['has_accepted_privacy_policy'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'first_name': first_name,
    'last_name': last_name,
    'password': password,
    'connection_code': connection_code,
    'email': email,
    'username': username,
    'gender': gender,
    'sexuality': sexuality,
    'partner_id': partner_id,
    'relation_ship_start_date': relation_ship_start_date,
    'has_accepted_terms_and_conditions': has_accepted_terms_and_conditions,
    'has_accepted_privacy_policy': has_accepted_privacy_policy,
  };
}
