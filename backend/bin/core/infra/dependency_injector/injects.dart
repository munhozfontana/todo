import '../../../app/apis/todo_api.dart';
import '../../../app/apis/user_api.dart';
import '../../../app/dao/todo_dao.dart';
import '../../../app/dao/user_dao.dart';
import '../../../app/services/todo_service.dart';
import '../../../app/services/user_service.dart';
import '../database/db_configuration.dart';
import '../database/mysql_db_configuration.dart';
import '../security/security_service.dart';
import '../security/security_service_imp.dart';
import 'dependency_injector.dart';

class Injects {
  static DependencyInjector initialize() {
    var di = DependencyInjector();

    di.register<DBConfiguration>(
      () => MySqlDBConfiguration(),
    );
    di.register<SecurityService>(
      () => SecurityServiceImp(),
    );

    // todo
    di.register<TodoDao>(
      () => TodoDao(di<DBConfiguration>()),
    );

    di.register<TodoService>(
      () => TodoService(di<TodoDao>()),
    );

    di.register<TodoApi>(
      () => TodoApi(
        di<TodoService>(),
        di<SecurityService>(),
      ),
    );

    // user
    di.register<UserDao>(
      () => UserDao(di<DBConfiguration>()),
    );
    di.register<UserService>(
      () => UserService(
        di<UserDao>(),
      ),
    );
    di.register<UserApi>(
      () => UserApi(
        di<UserService>(),
        di<SecurityService>(),
      ),
    );

    return di;
  }
}
