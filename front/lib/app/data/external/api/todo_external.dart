import 'package:todo/app/data/external/interfaces/i_todo_external.dart';
import 'package:todo/core/adapters/i_api_adapter.dart';

class TodoExternal implements ITodoExternal {
  final IApiAdapter iApiAdapter;

  TodoExternal({
    required this.iApiAdapter,
  });

  @override
  Future<int> add(Map entity) {
    // TODO: implement add
    throw UnimplementedError();
  }

  @override
  Future<bool> delete(int id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<List<Map>> findAll() {
    // TODO: implement findAll
    throw UnimplementedError();
  }

  @override
  Future<bool> update(Map entity) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
