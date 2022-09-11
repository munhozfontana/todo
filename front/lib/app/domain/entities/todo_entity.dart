class TodoEntity {
  int? id;
  String name;
  bool selected = false;

  TodoEntity({
    this.id,
    required this.name,
  });
}
