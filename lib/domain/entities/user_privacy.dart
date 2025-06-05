class UserPrivacyEntity {
  final int id;
  final int user;
  final bool allow_status_visibility;
  final bool allow_last_seen;

  UserPrivacyEntity({
    required this.id,
    required this.allow_last_seen,
    required this.allow_status_visibility,
    required this.user,
  });
}
