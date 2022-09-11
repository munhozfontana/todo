class UserEntity {
  final String email;
  final String password;

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
