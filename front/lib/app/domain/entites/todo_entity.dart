class TodoEntity {
  final int? id;
  final String name;

  TodoEntity({
    this.id,
    required this.name,
  });

  TodoEntity copyWith({
    int? id,
    String? name,
  }) {
    return TodoEntity(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }
}
