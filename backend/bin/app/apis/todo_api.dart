import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../../core/errors/errors.dart';
import '../../core/infra/security/security_service.dart';
import '../entities/todo_entity.dart';
import '../services/todo_service.dart';
import 'dto/todo/todo_dto.dart';
import 'utils/api.dart';

class TodoApi extends Api {
  final TodoService _service;
  final SecurityService _securityService;

  TodoApi(
    this._service,
    this._securityService,
  );

  @override
  String get path => 'todo';

  @override
  Handler getHandler({
    List<Middleware>? middlers,
    bool isSecurity = false,
  }) {
    final router = Router();

    router.get('/$path', (Request req) async {
      try {
        List<TodoDto> model = await _service.findAll();
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
        final userId = await _securityService.extractUserIDFromToken(
          req.headers['authorization'] as String,
        );
        var map = TodoDto.fromJson(body).toMap();
        final entity = TodoEntity.fromMap(map);
        entity.userId = userId;
        await _service.save(entity);

        return Response(201);
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
        var map = TodoDto.fromJson(body).toMap();
        final entity = TodoEntity.fromMap(map)..id = int.parse(id);
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
        var todoId = int.parse(id);

        final userTokenId = await _securityService.extractUserIDFromToken(
          req.headers['authorization'] as String,
        );
        final todo = await _service.findOne(todoId);

        if (todo == null) {
          return Response.forbidden('Todo not found');
        }

        if (todo.userId != userTokenId) {
          return Response.forbidden('User not authorized to remove this todo');
        }
        await _service.delete(todoId);
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
