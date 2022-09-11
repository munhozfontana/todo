import 'package:todo/app/data/models/todo_model.dart';

abstract class ITodoExternal {
  Future<int> add(TodoModel model);
  Future<bool> update(TodoModel model);
  Future<TodoModel> findByOne(int id);
  Future<List<TodoModel>> findAll();
  Future<bool> delete(int id);
}
