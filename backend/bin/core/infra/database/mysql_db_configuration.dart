import 'package:mysql1/mysql1.dart';

import '../../utils/custom_env.dart';
import 'db_configuration.dart';

class MySqlDBConfiguration implements DBConfiguration {
  MySqlConnection? _connection;

  @override
  Future<MySqlConnection> get connection async {
    _connection ??= await createConnection();
    if (_connection == null) {
      throw Exception('[ERROR/DB] -> Failed Create Connection');
    }
    return _connection!;
  }

  @override
  Future<MySqlConnection> createConnection() async =>
      await MySqlConnection.connect(
        ConnectionSettings(
          host: await CustomEnv.get<String>(key: 'db_host'),
          port: await CustomEnv.get<int>(key: 'db_port'),
          user: await CustomEnv.get<String>(key: 'db_user'),
          password: await CustomEnv.get<String>(key: 'db_pass'),
          db: await CustomEnv.get<String>(key: 'db_schema'),
        ),
      );

  @override
  execQuery(String sql, [List? params]) async {
    var conn = await connection;
    final res = await conn.query(sql, params);
    return res;
    // var teste = DBRespone(
    //   insertId: res.insertId,
    //   affectedRows: res.affectedRows,
    //   rows: rows,
    // );
  }
}

class DBRespone {
  final int? insertId;
  final int? affectedRows;
  final List<Map<String, dynamic>> rows;
  DBRespone({
    this.insertId,
    this.affectedRows,
    required this.rows,
  });
}
