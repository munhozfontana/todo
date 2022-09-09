import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../../core/errors/errors.dart';
import '../../core/infra/security/security_service.dart';
import '../entities/user_entity.dart';
import '../services/user_service.dart';
import 'dto/user/sign_in_dto.dart';
import 'dto/user/sign_up_dto.dart';
import 'utils/api.dart';

class UserApi extends Api {
  final UserService _userService;
  final SecurityService _securityService;

  UserApi(
    this._userService,
    this._securityService,
  );

  @override
  String get path => 'user';

  @override
  Handler getHandler({
    List<Middleware>? middlers,
    bool isSecurity = false,
  }) {
    final router = Router();

    router.post('/$path/sign-up', (Request req) async {
      var body = await req.readAsString();
      if (body.isEmpty) return Response(400);

      try {
        var map = SignUpDto.fromJson(body).toMap();
        await _userService.save(UserModel.fromMap(map));
        return Response(201);
      } on IBusinessException catch (e) {
        return Response.forbidden(e.toJson());
      } catch (e) {
        return Response.internalServerError();
      }
    });

    router.post('/$path/sign-in', (Request req) async {
      try {
        var body = await req.readAsString();
        var dto = SignInDto.fromJson(body);
        var userID = await _userService.authenticate(
          UserModel.fromMap(dto.toMap()),
        );
        if (userID != null) {
          var jwt = await _securityService.generateJWT(userID.id.toString());
          return Response.ok(jsonEncode({'token': jwt}));
        } else {
          return Response(401);
        }
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
