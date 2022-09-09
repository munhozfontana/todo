import '../../core/infra/database/db_configuration.dart';
import '../entities/todo_entity.dart';
import 'utils/dao.dart';

class TodoDao implements DAO<TodoEntity> {
  final DBConfiguration _dbConfiguration;

  TodoDao(this._dbConfiguration);
  @override
  Future<int> create(TodoEntity value) async {
    final result = await _dbConfiguration.execQuery(
      """
        INSERT INTO todo.todo_list
        (name, user_id)
        VALUES(?, ?);
        """,
      [
        value.name,
        value.userId,
      ],
    );
    return result.insertId!;
  }

  @override
  Future<bool> delete(int id) async {
    final res = await _dbConfiguration.execQuery(
      """
      DELETE FROM todo.todo_list
      WHERE id=?;
      """,
      [id],
    );
    return res.affectedRows != 0;
  }

  @override
  Future<List<TodoEntity>> findAll() async {
    final result = await _dbConfiguration.execQuery(
        ''' 
      SELECT id, name, user_id
      FROM todo.todo_list
      ''');

    return Map<TodoEntity, TodoEntity>.fromIterable(
      result.map(
        (e) => TodoEntity.fromMap(e.fields),
      ),
    ).entries.map((e) => e.value).toList();
  }

  @override
  Future<TodoEntity?> findOne(int id) async {
    var result = await _dbConfiguration.execQuery(
      ''' 
      SELECT id, name, user_id
      FROM todo.todo_list
      WHERE id = ? 
      LIMIT 1
      ''',
      [id],
    );
    if (result.isNotEmpty) {
      return TodoEntity.fromMap(result.single.fields);
    }
  }

  @override
  Future<bool> update(TodoEntity value) async {
    final result = await _dbConfiguration.execQuery(
      """
      UPDATE todo.todo_list
      SET name=?
      WHERE id=?;
      """,
      [
        value.name,
        value.id,
      ],
    );
    return result.affectedRows != 0;
  }
}
