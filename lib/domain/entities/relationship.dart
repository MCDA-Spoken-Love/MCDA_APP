class RelationshipEntity {
  final String user_one;
  final String user_two;
  final int id;
  final String relationship_start_date;

  RelationshipEntity({
    required this.id,
    required this.relationship_start_date,
    required this.user_one,
    required this.user_two,
  });

  factory RelationshipEntity.fromJson(Map<String, dynamic> json) {
    return RelationshipEntity(
      id: json['id'],
      relationship_start_date: json['relationship_start_date'],
      user_one: json['user_one'],
      user_two: json['user_two'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'user_one': user_one,
    'user_two': user_two,
    'relationship_start_date': relationship_start_date,
  };
}
