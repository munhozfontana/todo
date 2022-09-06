import 'dart:convert';

import '../i_dto.dart';

class SignInDto extends IDto {
  final String email;
  final String password;
  SignInDto({
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
    };
  }

  factory SignInDto.fromMap(Map<String, dynamic> map) {
    return SignInDto(
      email: map['email'] ?? '',
      password: map['password'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory SignInDto.fromJson(String source) =>
      SignInDto.fromMap(json.decode(source));
}
