import 'package:todo/app/domain/entities/todo_entity.dart';

abstract class ITodoRepository {
  Future<int> add(TodoEntity entity);
  Future<bool> update(TodoEntity entity);
  Future<List<TodoEntity>> findAll();
  Future<bool> delete(int id);
}
