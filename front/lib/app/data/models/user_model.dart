import 'dart:convert';

import 'package:todo/app/domain/entities/user_entity.dart';
import 'package:todo/app/domain/entities/vos/email_vo.dart';
import 'package:todo/app/domain/entities/vos/password_vo.dart';

class UserModel extends UserEntity {
  UserModel({
    required super.email,
    required super.password,
  });

  UserModel copyWith({
    EmailVo? email,
    PasswordVo? password,
  }) {
    return UserModel(
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email.value,
      'password': password.value,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      email: EmailVo(map['email']),
      password: PasswordVo(map['password']),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  factory UserModel.fromEntity(UserEntity entity) {
    return UserModel(
      email: entity.email,
      password: entity.password,
    );
  }
}
