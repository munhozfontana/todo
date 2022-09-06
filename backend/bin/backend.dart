import 'package:shelf/shelf.dart';

import 'app/apis/user_api.dart';
import 'core/infra/custom_server.dart';
import 'core/infra/dependency_injector/injects.dart';
import 'core/infra/middleware_interception.dart';
import 'core/utils/custom_env.dart';

void main() async {
  CustomEnv.fromFile('dev.env');

  final di = Injects.initialize();

  var cascadeHandler =
      Cascade().add(di.get<UserApi>().getHandler(isSecurity: false)).handler;

  var handler = Pipeline()
      .addMiddleware(logRequests())
      .addMiddleware(MInterception.contentTypeJson)
      .addMiddleware(MInterception.cors)
      .addHandler(cascadeHandler);

  await CustomServer().initialize(
    handler: handler,
    address: await CustomEnv.get<String>(key: 'server_address'),
    port: await CustomEnv.get<int>(key: 'server_port'),
  );
}
