import 'package:mysql1/mysql1.dart';

abstract class DBConfiguration {
  Future<dynamic> createConnection();

  Future<dynamic> get connection;

  Future<Results> execQuery(String sql, [List? params]);
}
