import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../../core/errors/errors.dart';
import '../entities/task_entity.dart';
import '../services/task_service.dart';
import 'dto/task/task_dto.dart';
import 'utils/api.dart';

class TaskApi extends Api {
  final TaskService _service;

  TaskApi(
    this._service,
  );

  @override
  String get path => 'task';

  @override
  Handler getHandler({
    List<Middleware>? middlers,
    bool isSecurity = false,
  }) {
    final router = Router();

    router.get('/$path/<id>', (Request req, String id) async {
      try {
        TaskDto model = await _service.findOne(int.parse(id));
        return Response.ok(model.toJson());
      } on IBusinessException catch (e) {
        return Response.forbidden(e.toJson());
      } catch (e) {
        return Response.internalServerError();
      }
    });

    router.get('/$path', (Request req) async {
      try {
        List<TaskDto> model = await _service.findAll();
        List<Map> map = model.map((e) => e.toMap()).toList();
        return Response.ok(jsonEncode(map));
      } on IBusinessException catch (e) {
        return Response.forbidden(e.toJson());
      } catch (e) {
        return Response.internalServerError();
      }
    });

    router.post('/$path', (Request req) async {
      var body = await req.readAsString();

      if (body.isEmpty) return Response(400);

      try {
        var map = TaskDto.fromJson(body).toMap();
        final entity = TaskEntity.fromMap(map);
        final savedEntity = await _service.save(entity);
        return Response(201, body: savedEntity.toJson());
      } on IBusinessException catch (e) {
        return Response.forbidden(e.toJson());
      } catch (e) {
        return Response.internalServerError();
      }
    });

    router.put('/$path/<id>', (Request req, String id) async {
      var body = await req.readAsString();
      if (body.isEmpty) return Response(400);

      try {
        var map = TaskDto.fromJson(body).toMap();
        final entity = TaskEntity.fromMap(map)..id = int.parse(id);
        await _service.save(entity);
        return Response(201);
      } on IBusinessException catch (e) {
        return Response.forbidden(e.toJson());
      } catch (e) {
        return Response.internalServerError();
      }
    });

    router.delete('/$path/<id>', (Request req, String id) async {
      try {
        await _service.delete(int.parse(id));
        return Response(201);
      } on IBusinessException catch (e) {
        return Response.forbidden(e.toJson());
      } catch (e) {
        return Response.internalServerError();
      }
    });

    return createHandler(
      router: router,
      isSecurity: isSecurity,
      middlers: middlers,
    );
  }
}
