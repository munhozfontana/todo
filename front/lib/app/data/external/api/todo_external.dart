import 'dart:convert';

import 'package:todo/app/data/external/interfaces/i_todo_external.dart';
import 'package:todo/app/data/models/todo_model.dart';
import 'package:todo/core/adapters/api_adapter.dart';
import 'package:todo/core/adapters/i_api_adapter.dart';
import 'package:todo/core/environment.dart';
import 'package:todo/core/errors/i_business_exception.dart';

class TodoExternal implements ITodoExternal {
  final IApiAdapter iApiAdapter;

  TodoExternal({
    required this.iApiAdapter,
  });

  @override
  Future<int> add(TodoModel model) async {
    final res = await iApiAdapter.postHttp(
      '${Environment.host.value}/todo',
      body: model.toJson(),
    );

    if (res.body == null) {
      throw ExternalException('body not found');
    }

    return toMap(res)['id'];
  }

  @override
  Future<bool> delete(int id) async {
    final res = await iApiAdapter.deleteHttp(
      '${Environment.host.value}/todo/$id',
    );

    if (res.body == null) {
      throw ExternalException('body not found');
    }

    return true;
  }

  @override
  Future<List<TodoModel>> findAll() async {
    final res = await iApiAdapter.getHttp(
      '${Environment.host.value}/todo',
    );

    if (res.body == null) {
      throw ExternalException('body not found');
    }

    List json = await jsonDecode(res.body!);

    return json.map((e) => TodoModel.fromMap(e)).toList();
  }

  @override
  Future<bool> update(TodoModel model) async {
    final res = await iApiAdapter.postHttp(
      '${Environment.host.value}/todo',
      body: model.toJson(),
    );

    if (res.body == null) {
      throw ExternalException('body not found');
    }

    return true;
  }

  @override
  Future<TodoModel> findByOne(int id) async {
    final res = await iApiAdapter.getHttp(
      '${Environment.host.value}/todo/$id',
    );

    if (res.body == null) {
      throw ExternalException('body not found');
    }

    return TodoModel.fromJson(res.body!);
  }
}
