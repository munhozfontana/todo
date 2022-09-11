class UserEntity {
  String email;
  String password;

  UserEntity({
    required this.email,
    required this.password,
  });

  static UserEntity empty() {
    return UserEntity(
      email: '',
      password: '',
    );
  }
}
