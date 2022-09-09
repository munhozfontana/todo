import 'dart:convert';

import '../i_dto.dart';

class TaskDto extends IDto {
  int? id;
  String name;
  int todoId;
  int? taskParentID;

  TaskDto({
    this.id,
    required this.name,
    required this.todoId,
    this.taskParentID,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'todo_id': todoId,
      'task_parent_id': taskParentID,
    };
  }

  factory TaskDto.fromMap(Map<String, dynamic> map) {
    return TaskDto(
      id: map['id']?.toInt(),
      name: map['name'] ?? '',
      todoId: map['todo_id']?.toInt() ?? 0,
      taskParentID: map['task_parent_id']?.toInt(),
    );
  }

  @override
  String toJson() => json.encode(toMap());

  factory TaskDto.fromJson(String source) =>
      TaskDto.fromMap(json.decode(source));
}
