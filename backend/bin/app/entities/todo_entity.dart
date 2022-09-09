import 'dart:convert';

class TodoEntity {
  int? id;
  String name;
  int userId;

  TodoEntity({
    this.id,
    required this.name,
    required this.userId,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'user_id': userId,
    };
  }

  factory TodoEntity.fromMap(Map<String, dynamic> map) {
    return TodoEntity(
      id: map['id']?.toInt(),
      name: map['name'] ?? '',
      userId: map['user_id']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory TodoEntity.fromJson(String source) =>
      TodoEntity.fromMap(json.decode(source));
}
