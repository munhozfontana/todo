import 'package:todo/app/domain/entities/todo_entity.dart';

import '../../domain/repositories/i_todo_repository.dart';

class TodoRepository implements ITodoRepository {
  @override
  Future<int> add(TodoEntity value) {
    // TODO: implement add
    throw UnimplementedError();
  }

  @override
  Future<bool> delete(int id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<List<TodoEntity>> findAll() {
    // TODO: implement findAll
    throw UnimplementedError();
  }

  @override
  Future<bool> update(TodoEntity value) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
