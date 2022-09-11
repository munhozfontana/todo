import 'dart:convert';

import 'package:todo/app/domain/entities/task_entity.dart';

class TaskModel {
  int? id;
  String name;
  int todoId;
  int? taskParentId;

  TaskModel({
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

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      id: map['id']?.toInt(),
      name: map['name'] ?? '',
      todoId: map['todo_id']?.toInt() ?? 0,
      taskParentId: map['task_parent_id']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory TaskModel.fromJson(String source) =>
      TaskModel.fromMap(json.decode(source));

  TaskEntity toEntity() {
    return TaskEntity(
        id: id,
        name: name,
        todoId: todoId,
        taskEntity: taskParentId != null
            ? TaskEntity(
                id: taskParentId,
                name: '',
                todoId: 0,
              )
            : null);
  }

  static TaskModel fromEntity(TaskEntity entity) {
    return TaskModel(
      id: entity.id,
      name: entity.name,
      taskParentId: entity.taskEntity?.id,
      todoId: entity.todoId,
    );
  }
}
