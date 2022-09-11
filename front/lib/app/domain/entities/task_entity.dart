class TaskEntity {
  int? id;
  String name;
  List<TaskEntity>? taskFather;

  TaskEntity({
    this.id,
    required this.name,
    this.taskFather,
  });
}
