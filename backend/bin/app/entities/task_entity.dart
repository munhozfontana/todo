import 'dart:convert';

class TaskEntity {
  int? id;
  String name;
  int todoId;
  int? taskParentId;
  TaskEntity({
    this.id,
    required this.name,
    required this.todoId,
    this.taskParentId,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'todo_id': todoId,
      'task_parent_id': taskParentId,
    };
  }

  factory TaskEntity.fromMap(Map<String, dynamic> map) {
    return TaskEntity(
      id: map['id']?.toInt(),
      name: map['name'] ?? '',
      todoId: map['todo_id']?.toInt() ?? 0,
      taskParentId: map['task_parent_id']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory TaskEntity.fromJson(String source) =>
      TaskEntity.fromMap(json.decode(source));
}
