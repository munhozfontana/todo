import 'package:todo/app/data/models/user_model.dart';

abstract class IUserExternal {
  Future<String> signIn(UserModel model);
  Future<void> signUp(UserModel model);
}
