import 'package:email_validator/email_validator.dart';
import 'package:todo/app/domain/entities/vos/value_object.dart';

class EmailVo implements ValueObject {
  String value;

  EmailVo(this.value);

  @override
  String? validator(String? inputValue) {
    if (inputValue == null || inputValue.isEmpty) {
      return 'Field email is required';
    }

    if (!EmailValidator.validate(value)) {
      return 'Email not valid';
    }
    return null;
  }

  @override
  void onChange(String changeValue) {
    value = changeValue;
  }
}
