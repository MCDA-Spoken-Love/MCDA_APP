class RelationshipEntity {
  final String user_one_id;
  final String user_two_id;
  final int id;
  final String relationship_start_date;

  RelationshipEntity({
    required this.id,
    required this.relationship_start_date,
    required this.user_one_id,
    required this.user_two_id,
  });

  factory RelationshipEntity.fromJson(Map<String, dynamic> json) {
    return RelationshipEntity(
      id: json['id'],
      relationship_start_date: json['relationship_start_date'],
      user_one_id: json['user_one_id'],
      user_two_id: json['user_two_id'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'user_one_id': user_one_id,
    'user_two_id': user_two_id,
    'relationship_start_date': relationship_start_date,
  };
}
