import 'dart:convert';

import '../i_dto.dart';

class UserDto extends IDto {
  int? id;
  String email;
  String password;

  UserDto({
    this.id,
    required this.email,
    required this.password,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'password': password,
    };
  }

  factory UserDto.fromMap(Map<String, dynamic> map) {
    return UserDto(
      id: map['id']?.toInt(),
      email: map['email'] ?? '',
      password: map['password'] ?? '',
    );
  }

  @override
  String toJson() => json.encode(toMap());

  factory UserDto.fromJson(String source) =>
      UserDto.fromMap(json.decode(source));
}
