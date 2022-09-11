import 'package:todo/app/data/models/todo_model.dart';

abstract class ITodoExternal {
  Future<int> add(TodoModel model);
  Future<bool> update(TodoModel model);
  Future<List<TodoModel>> findAll();
  Future<bool> delete(int id);
}
