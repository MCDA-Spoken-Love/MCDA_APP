class UserPrivacyEntity {
  final int id;
  final String user;
  final bool allow_status_visibility;
  final bool allow_last_seen;

  UserPrivacyEntity({
    required this.id,
    required this.allow_last_seen,
    required this.allow_status_visibility,
    required this.user,
  });

  factory UserPrivacyEntity.fromJson(Map<String, dynamic> json) {
    return UserPrivacyEntity(
      id: json['id'],
      allow_last_seen: json['allow_last_seen'],
      allow_status_visibility: json['allow_status_visibility'],
      user: json['user'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'allow_last_seen': allow_last_seen,
    'allow_status_visibility': allow_status_visibility,
    'user': user,
  };
}
