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
  final DateTime? relation_ship_start_date;
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
}
