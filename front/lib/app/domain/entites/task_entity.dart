class TaskEntity {
  final int? id;
  final String name;
  final List<TaskEntity>? taskFather;

  TaskEntity({
    this.id,
    required this.name,
    this.taskFather,
  });
}
