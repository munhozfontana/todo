import '../../core/infra/database/db_configuration.dart';
import '../entities/user_entity.dart';
import 'utils/dao.dart';

class UserDao implements DAO<UserModel> {
  final DBConfiguration _dbConfiguration;

  UserDao(this._dbConfiguration);

  @override
  Future<int> create(UserModel value) async {
    final result = await _dbConfiguration.execQuery(
      '''INSERT INTO todo.user
      (email, password)
      VALUES(?, ?)''',
      [
        value.email,
        value.password,
      ],
    );

    return result.insertId!;
  }

  @override
  Future<bool> delete(int id) async {
    final res = await _dbConfiguration.execQuery(
      """
      DELETE FROM todo.user
      WHERE id = ?
      """,
      [id],
    );
    return res.affectedRows != 0;
  }

  @override
  Future<List<UserModel>> findAll() async {
    final result = await _dbConfiguration.execQuery(''' 
      SELECT id, email, password
      FROM todo.user
      ''');

    return Map<UserModel, UserModel>.fromIterable(
      result.map(
        (e) => UserModel.fromMap(e.fields),
      ),
    ).entries.map((e) => e.value).toList();
  }

  @override
  Future<UserModel?> findOne(int id) async {
    var result = await _dbConfiguration.execQuery('''
          SELECT
            id,
            email,
            password
          FROM
            todo.user WHERE id = ? 
          LIMIT 1
      ''', [id]);

    return UserModel.fromMap(result.single.fields);
  }

  @override
  Future<bool> update(UserModel value) async {
    final result = await _dbConfiguration.execQuery(
      """
         UPDATE todo.user
          SET
          email = ?,
          password = ?
          WHERE id = ?
      """,
      [
        value.id,
        value.email,
        value.password,
      ],
    );
    return result.affectedRows != 0;
  }

  Future<UserModel?> findByEmail(String email) async {
    var r = await _dbConfiguration
        .execQuery('select * from todo.user where email = ?', [email]);
    return r.isEmpty ? null : UserModel.fromMap(r.first.fields);
  }
}
