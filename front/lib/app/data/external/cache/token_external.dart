import 'dart:html';

import '../interfaces/i_token_external.dart';

class TokenExternal implements ITokenExternal {
  @override
  String? get() {
    var res = window.localStorage['token_key'];
    return res;
  }

  @override
  void save(String token) {
    window.localStorage.addAll({'token_key': token});

    return;
  }
}
