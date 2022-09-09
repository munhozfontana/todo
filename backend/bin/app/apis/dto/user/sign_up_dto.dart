import 'dart:convert';

import '../i_dto.dart';

class SignUpDto extends IDto {
  String email;
  String password;

  SignUpDto({
    required this.email,
    required this.password,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
    };
  }

  factory SignUpDto.fromMap(Map<String, dynamic> map) {
    return SignUpDto(
      email: map['email'] ?? '',
      password: map['password'] ?? '',
    );
  }

  @override
  String toJson() => json.encode(toMap());

  factory SignUpDto.fromJson(String source) =>
      SignUpDto.fromMap(json.decode(source));
}
