import 'package:todo/app/domain/entities/vos/email_vo.dart';
import 'package:todo/app/domain/entities/vos/password_vo.dart';

class UserEntity {
  final EmailVo email;
  final PasswordVo password;

  UserEntity({
    required this.email,
    required this.password,
  });

  static UserEntity empty() {
    return UserEntity(
      email: EmailVo(''),
      password: PasswordVo(''),
    );
  }
}
