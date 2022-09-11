import 'package:email_validator/email_validator.dart' as lib;
import 'package:todo/app/domain/entities/validators/utils/i_validator.dart';

class EmailValidator implements IValidator {
  @override
  String? call(String? inputValue) {
    if (inputValue == null || inputValue.isEmpty) {
      return 'Field email is required';
    }

    if (!lib.EmailValidator.validate(inputValue)) {
      return 'Email not valid';
    }
    return null;
  }
}
