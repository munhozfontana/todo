import 'dart:convert';

import 'package:todo/app/domain/entities/todo_entity.dart';

class TodoModel {
  final int? id;
  final String name;

  TodoModel({
    this.id,
    required this.name,
  });

  factory TodoModel.fromEntity(TodoEntity entity) {
    return TodoModel(
      id: entity.id,
      name: entity.name,
    );
  }

  TodoEntity toEntity() {
    return TodoEntity(
      id: id,
      name: name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  factory TodoModel.fromMap(Map<String, dynamic> map) {
    return TodoModel(
      id: map['id']?.toInt(),
      name: map['name'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory TodoModel.fromJson(String source) =>
      TodoModel.fromMap(json.decode(source));
}
