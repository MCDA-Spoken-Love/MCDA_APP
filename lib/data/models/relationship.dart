import 'package:mcda_app/domain/entities/relationship.dart';

class RelationshipModel {
  final String user_one;
  final String user_two;
  final int id;
  final String relationship_start_date;

  RelationshipModel({
    required this.id,
    required this.relationship_start_date,
    required this.user_one,
    required this.user_two,
  });

  factory RelationshipModel.fromMap(Map<String, dynamic> map) {
    return RelationshipModel(
      id: map['id'],
      relationship_start_date: map['relationship_start_date'],
      user_one: map['user_one'],
      user_two: map['user_two'],
    );
  }
}

extension RelationshipXModel on RelationshipModel {
  RelationshipEntity toEntity() {
    return RelationshipEntity(
      id: id,
      relationship_start_date: relationship_start_date,
      user_one: user_one,
      user_two: user_two,
    );
  }
}
