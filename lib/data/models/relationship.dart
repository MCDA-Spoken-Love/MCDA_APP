import 'package:mcda_app/domain/entities/relationship.dart';

class RelationshipModel {
  final String user_one_id;
  final String user_two_id;
  final int id;
  final String relationship_start_date;

  RelationshipModel({
    required this.id,
    required this.relationship_start_date,
    required this.user_one_id,
    required this.user_two_id,
  });

  factory RelationshipModel.fromMap(Map<String, dynamic> map) {
    return RelationshipModel(
      id: map['id'],
      relationship_start_date: map['relationship_start_date'],
      user_one_id: map['user_one_id'],
      user_two_id: map['user_two_id'],
    );
  }
}

extension RelationshipXModel on RelationshipModel {
  RelationshipEntity toEntity() {
    return RelationshipEntity(
      id: id,
      relationship_start_date: relationship_start_date,
      user_one_id: user_one_id,
      user_two_id: user_two_id,
    );
  }
}
