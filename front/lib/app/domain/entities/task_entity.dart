class TaskEntity {
  int? id;
  String name;
  int todoId;
  TaskEntity? taskEntity;

  bool selected = false;

  TaskEntity({
    this.id,
    required this.name,
    required this.todoId,
    this.taskEntity,
  });
}
