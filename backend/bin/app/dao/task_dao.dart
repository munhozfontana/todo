import '../../core/infra/database/db_configuration.dart';
import '../entities/task_entity.dart';
import 'utils/dao.dart';

class TaskDao implements DAO<TaskEntity> {
  final DBConfiguration _dbConfiguration;

  TaskDao(this._dbConfiguration);
  @override
  Future<int> create(TaskEntity value) async {
    final result = await _dbConfiguration.execQuery(
      """
        INSERT INTO todo.task
        (name, todo_id, task_parent_id)
        VALUES(?, ?, ?);
        """,
      [
        value.name,
        value.todoId,
        value.taskParentId,
      ],
    );
    return result.insertId!;
  }

  @override
  Future<bool> delete(int id) async {
    final res = await _dbConfiguration.execQuery(
      """
      DELETE FROM todo.task
      WHERE id=?;
      """,
      [id],
    );
    return res.affectedRows != 0;
  }

  @override
  Future<List<TaskEntity>> findAll() async {
    final result = await _dbConfiguration.execQuery(
        ''' 
      SELECT id, name, todo_id, task_parent_id
      FROM todo.task
      ''');

    return Map<TaskEntity, TaskEntity>.fromIterable(
      result.map(
        (e) => TaskEntity.fromMap(e.fields),
      ),
    ).entries.map((e) => e.value).toList();
  }

  @override
  Future<TaskEntity?> findOne(int id) async {
    var result = await _dbConfiguration.execQuery(
      ''' 
      SELECT id, name, todo_id, task_parent_id
      FROM todo.task
      WHERE id = ? 
      LIMIT 1
      ''',
      [id],
    );
    if (result.isNotEmpty) {
      return TaskEntity.fromMap(result.single.fields);
    }
  }

  @override
  Future<bool> update(TaskEntity value) async {
    final result = await _dbConfiguration.execQuery(
      """
      UPDATE todo.task
      SET name=?, todo_id=?, task_parent_id=?
      WHERE id=?;
      """,
      [
        value.name,
        value.todoId,
        value.taskParentId,
        value.id,
      ],
    );
    return result.affectedRows != 0;
  }
}
