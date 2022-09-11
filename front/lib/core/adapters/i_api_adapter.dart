abstract class IApiAdapter {
  Future<HttpResponse> getHttp(
    String? url, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
  });
  Future<HttpResponse> putHttp(
    String? url, {
    Map<String, dynamic>? headers,
    dynamic body,
    Map<String, dynamic>? queryParameters,
  });
  Future<HttpResponse> postHttp(
    String? url, {
    Map<String, dynamic>? headers,
    dynamic body,
    Map<String, dynamic>? queryParameters,
  });
  Future<HttpResponse> deleteHttp(
    String? url, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
  });
}

class HttpResponse {
  HttpResponse({
    this.statusCode,
    this.body,
    this.header,
  });

  int? statusCode;
  String? body;
  Map? header;
}

class HttpDownload {
  HttpDownload({
    this.statusCode,
    this.body,
    this.header,
  });

  int? statusCode;
  List<int>? body;
  Map? header;
}
