import 'package:mcda_app/domain/entities/user_privacy.dart';

class UserPrivacyModel {
  final int id;
  final bool allow_last_seen;
  final String user;
  final bool allow_status_visibility;

  UserPrivacyModel({
    required this.id,
    required this.user,
    required this.allow_status_visibility,
    required this.allow_last_seen,
  });

  factory UserPrivacyModel.fromMap(Map<String, dynamic> map) {
    return UserPrivacyModel(
      id: map['id'],
      allow_last_seen: map['allow_last_seen'],
      allow_status_visibility: map['allow_status_visibility'],
      user: map['user'],
    );
  }
}

extension UserXModel on UserPrivacyModel {
  UserPrivacyEntity toEntity() {
    return UserPrivacyEntity(
      id: id,
      allow_last_seen: allow_last_seen,
      allow_status_visibility: allow_status_visibility,
      user: user,
    );
  }
}
