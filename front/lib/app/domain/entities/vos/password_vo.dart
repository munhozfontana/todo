import 'package:todo/app/domain/entities/vos/value_object.dart';

class PasswordVo implements ValueObject {
  String value;

  PasswordVo(this.value);

  @override
  String? validator(value) {
    if (value == null || value.isEmpty) {
      return 'Field password is required';
    }

    if (value.length < 8) {
      return 'Min 8 characters to password';
    }
    return null;
  }

  @override
  void onChange(String changeValue) {
    value = changeValue;
  }
}
