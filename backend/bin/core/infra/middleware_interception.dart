import 'package:shelf/shelf.dart';

class MInterception {
  static Middleware get contentTypeJson => createMiddleware(
        responseHandler: (Response res) => res.change(
          headers: {
            'content-type': 'application/json',
          },
        ),
      );

  static Middleware get cors {
    final headersAllows = {
      "Access-Control-Allow-Origin": "*",
      "Access-Control-Allow-Headers": "*",
      "Access-Control-Allow-Methods": "GET, POST, DELETE, OPTIONS"
    };

    Response? handlerOption(Request req) {
      if (req.method == 'OPTIONS') {
        return Response(200, headers: headersAllows);
      }
      return null;
    }

    Response addCorsHeader(Response res) => res.change(headers: headersAllows);

    return createMiddleware(
      requestHandler: handlerOption,
      responseHandler: addCorsHeader,
    );
  }
}
