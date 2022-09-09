import 'dart:convert';

import '../i_dto.dart';

class TodoDto extends IDto {
  int? id;
  String name;
  int userId;
  TodoDto({
    this.id,
    required this.name,
    required this.userId,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'user_id': userId,
    };
  }

  factory TodoDto.fromMap(Map<String, dynamic> map) {
    return TodoDto(
      id: map['id']?.toInt(),
      name: map['name'] ?? '',
      userId: map['user_id']?.toInt() ?? 0,
    );
  }

  @override
  String toJson() => json.encode(toMap());

  factory TodoDto.fromJson(String source) =>
      TodoDto.fromMap(json.decode(source));
}
