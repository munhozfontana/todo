import 'dart:async';

import 'package:todo/core/errors/i_business_exception.dart';

class MainController {
  final StreamController<String> _streamController = StreamController();

  void onError(IBusinessException text) {
    _streamController.sink.add(text.message);
  }

  Stream<String> of() {
    return _streamController.stream;
  }

  void dispose() {
    _streamController.close();
  }
}
