import '../../domain/entities/user.dart';

class UserModel {
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

  UserModel({
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

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      gender: map['gender'],
      sexuality: map['sexuality'],
      partner_id: map['partner_id'],
      relation_ship_start_date: map['relation_ship_start_date'],
      has_accepted_terms_and_conditions:
          map['has_accepted_terms_and_conditions'],
      has_accepted_privacy_policy: map['has_accepted_privacy_policy'],
      first_name: map['first_name'],
      last_name: map['last_name'],
      id: map['id'],
      password: map['password'],
      connection_code: map['connection_code'],
      email: map['email'],
      username: map['username'],
    );
  }
}

extension UserXModel on UserModel {
  UserEntity toEntity() {
    return UserEntity(
      email: email,
      username: username,
      first_name: first_name,
      last_name: last_name,
      id: id,
      password: password,
      connection_code: connection_code,
      gender: gender,
      sexuality: sexuality,
      partner_id: partner_id,
      relation_ship_start_date: relation_ship_start_date,
      has_accepted_terms_and_conditions: has_accepted_terms_and_conditions,
      has_accepted_privacy_policy: has_accepted_privacy_policy,
    );
  }
}
