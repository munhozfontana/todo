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

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TaskEntity &&
        other.id == id &&
        other.name == name &&
        other.todoId == todoId &&
        other.selected == selected;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ todoId.hashCode ^ selected.hashCode;
  }
}
