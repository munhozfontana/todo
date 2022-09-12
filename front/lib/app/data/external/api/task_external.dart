import 'dart:convert';

import 'package:todo/app/data/external/interfaces/i_task_external.dart';
import 'package:todo/app/data/models/task_model.dart';
import 'package:todo/core/adapters/api_adapter.dart';
import 'package:todo/core/adapters/i_api_adapter.dart';
import 'package:todo/core/environment.dart';
import 'package:todo/core/errors/i_business_exception.dart';

class TaskExternal implements ITaskExternal {
  final IApiAdapter iApiAdapter;

  TaskExternal({
    required this.iApiAdapter,
  });

  @override
  Future<int> add(TaskModel model) async {
    final res = await iApiAdapter.postHttp(
      '${Environment.host.value}/task',
      body: model.toJson(),
    );

    if (res.body == null) {
      throw ExternalException('body not found');
    }

    return toMap(res)['id'];
  }

  @override
  Future<bool> delete(int id) async {
    await iApiAdapter.deleteHttp(
      '${Environment.host.value}/task/$id',
    );

    return true;
  }

  @override
  Future<List<TaskModel>> findAll() async {
    final res = await iApiAdapter.getHttp(
      '${Environment.host.value}/task',
    );

    if (res.body == null) {
      throw ExternalException('body not found');
    }

    List json = await jsonDecode(res.body!);

    return json.map((e) => TaskModel.fromMap(e)).toList();
  }

  @override
  Future<bool> update(TaskModel model) async {
    final res = await iApiAdapter.putHttp(
      '${Environment.host.value}/task/${model.id}',
      body: model.toJson(),
    );

    if (res.body == null) {
      throw ExternalException('body not found');
    }

    return true;
  }

  @override
  Future<TaskModel> findByOne(int id) async {
    final res = await iApiAdapter.getHttp(
      '${Environment.host.value}/task/$id',
    );

    if (res.body == null) {
      throw ExternalException('body not found');
    }

    return TaskModel.fromJson(res.body!);
  }
}
