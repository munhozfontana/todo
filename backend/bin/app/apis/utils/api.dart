import 'package:shelf/shelf.dart';

import '../../../core/infra/dependency_injector/dependency_injector.dart';
import '../../../core/infra/security/security_service.dart';

abstract class Api {
  String path = '';

  Handler getHandler({
    List<Middleware>? middlers,
    bool isSecurity = false,
  });

  Handler createHandler({
    required Handler router,
    List<Middleware>? middlers,
    bool isSecurity = false,
  }) {
    middlers ??= [];

    if (isSecurity) {
      var securityService = DependencyInjector().get<SecurityService>();
      middlers.addAll([
        securityService.authorization,
        securityService.verifyJwt,
      ]);
    }

    var pipe = Pipeline();
    for (var item in middlers) {
      pipe = pipe.addMiddleware(item);
    }

    return pipe.addHandler(router);
  }
}
