import 'package:todo/app/data/models/task_model.dart';

abstract class ITaskExternal {
  Future<int> add(TaskModel model);
  Future<bool> update(TaskModel model);
  Future<TaskModel> findByOne(int id);
  Future<List<TaskModel>> findAll();
  Future<bool> delete(int id);
}
