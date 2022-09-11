import 'package:todo/app/domain/entities/validators/utils/i_validator.dart';

class PasswordValidator implements IValidator {
  @override
  String? call(String? inputValue) {
    if (inputValue == null || inputValue.isEmpty) {
      return 'Field password is required';
    }

    if (inputValue.length < 8) {
      return 'Min 8 characters to password';
    }
    return null;
  }
}
