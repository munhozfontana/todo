import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:todo/app/data/external/api/task_external.dart';
import 'package:todo/app/data/external/api/todo_external.dart';
import 'package:todo/app/data/external/api/user_external.dart';
import 'package:todo/app/data/external/cache/token_external.dart';
import 'package:todo/app/data/external/interfaces/i_task_external.dart';
import 'package:todo/app/data/external/interfaces/i_todo_external.dart';
import 'package:todo/app/data/repositories/task_repository.dart';
import 'package:todo/app/data/repositories/todo_repository.dart';
import 'package:todo/app/data/repositories/user_repository.dart';
import 'package:todo/app/domain/repositories/i_task_repository.dart';
import 'package:todo/app/domain/repositories/i_todo_repository.dart';
import 'package:todo/app/domain/repositories/i_user_repository.dart';
import 'package:todo/app/domain/usecases/interfaces/todo/i_add_todo_usecase.dart';
import 'package:todo/app/domain/usecases/interfaces/todo/i_delete_todo_usecase.dart';
import 'package:todo/app/domain/usecases/interfaces/todo/i_find_all_todo_usecase.dart';
import 'package:todo/app/domain/usecases/interfaces/todo/i_update_todo_usecase.dart';
import 'package:todo/app/domain/usecases/interfaces/user/i_logged_usecase.dart';
import 'package:todo/app/domain/usecases/interfaces/user/i_sign_in_usecase.dart';
import 'package:todo/app/domain/usecases/interfaces/user/i_sign_up_usecase.dart';
import 'package:todo/app/domain/usecases/todo/add_todo_usecase.dart';
import 'package:todo/app/domain/usecases/user/logged_usecase.dart';
import 'package:todo/app/domain/usecases/user/sign_in_usecase.dart';
import 'package:todo/app/domain/usecases/user/sign_up_usecase.dart';
import 'package:todo/app/ui/features/home/home_controller.dart';
import 'package:todo/app/ui/features/home/task/task_controller.dart';
import 'package:todo/app/ui/features/login/login_controller.dart';
import 'package:todo/core/adapters/api_adapter.dart';
import 'package:todo/main_controller.dart';

import 'app/data/external/interfaces/i_token_external.dart';
import 'app/data/external/interfaces/i_user_external.dart';
import 'app/domain/usecases/interfaces/task/i_add_task_usecase.dart';
import 'app/domain/usecases/interfaces/task/i_delete_task_usecase.dart';
import 'app/domain/usecases/interfaces/task/i_find_all_task_usecase.dart';
import 'app/domain/usecases/interfaces/task/i_update_task_usecase.dart';
import 'app/domain/usecases/task/add_task_usecase.dart';
import 'app/domain/usecases/task/delete_task_usecase.dart';
import 'app/domain/usecases/task/find_all_task_usecase.dart';
import 'app/domain/usecases/task/update_task_usecase.dart';
import 'app/domain/usecases/todo/delete_todo_usecase.dart';
import 'app/domain/usecases/todo/find_all_todo_usecase.dart';
import 'app/domain/usecases/todo/update_todo_usecase.dart';
import 'core/adapters/i_api_adapter.dart';

final inject = GetIt.instance;

void injection() {
  _flutter();

  _adapters();

  _external();

  _repository();

  _usecase();

  _controllers();
}

void _flutter() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.manual,
    overlays: SystemUiOverlay.values,
  );
}

void _adapters() {
  inject.registerFactory<IApiAdapter>(
    () => ApiAdapter(iTokenExternal: inject()),
  );
}

void _external() {
  inject.registerFactory<ITokenExternal>(
    () => TokenExternal(),
  );

  inject.registerFactory<IUserExternal>(
    () => UserExternal(
      iApiAdapter: inject(),
    ),
  );

  inject.registerFactory<ITodoExternal>(
    () => TodoExternal(
      iApiAdapter: inject(),
    ),
  );

  inject.registerFactory<ITaskExternal>(
    () => TaskExternal(
      iApiAdapter: inject(),
    ),
  );
}

void _repository() {
  inject.registerFactory<IUserRepository>(
    () => UserRepository(
      iTokenExternal: inject(),
      iUserExternal: inject(),
    ),
  );

  inject.registerFactory<ITodoRepository>(
    () => TodoRepository(
      iTodoExternal: inject(),
    ),
  );

  inject.registerFactory<ITaskRepository>(
    () => TaskRepository(
      iTaskExternal: inject(),
    ),
  );
}

void _usecase() {
  inject.registerFactory<IAddTaskUsecase>(
    () => AddTaskUsecase(
      iTaskRepository: inject(),
    ),
  );
  inject.registerFactory<IDeleteTaskUsecase>(
    () => DeleteTaskUsecase(
      iTaskRepository: inject(),
    ),
  );
  inject.registerFactory<IFindAllTaskUsecase>(
    () => FindAllTaskUsecase(
      iTaskRepository: inject(),
    ),
  );
  inject.registerFactory<IUpdateTaskUsecase>(
    () => UpdateTaskUsecase(
      iTaskRepository: inject(),
    ),
  );

  inject.registerFactory<ISignInUsecase>(
    () => SignInUsecase(
      iUserRepository: inject(),
    ),
  );
  inject.registerFactory<ISignUpUsecase>(
    () => SignUpUsecase(
      iUserRepository: inject(),
    ),
  );

  inject.registerFactory<ILoggedUsecase>(
    () => LoggedUsecase(
      iUserRepository: inject(),
    ),
  );

  inject.registerFactory<IAddTodoUsecase>(
    () => AddTodoUsecase(
      iTodoRepository: inject(),
    ),
  );
  inject.registerFactory<IDeleteTodoUsecase>(
    () => DeleteTodoUsecase(
      iTodoRepository: inject(),
    ),
  );
  inject.registerFactory<IFindAllTodoUsecase>(
    () => FindAllTodoUsecase(
      iTodoRepository: inject(),
    ),
  );
  inject.registerFactory<IUpdateTodoUsecase>(
    () => UpdateTodoUsecase(
      iTodoRepository: inject(),
    ),
  );
}

void _controllers() {
  inject.registerLazySingleton(
    () => LoginController(
      isAuthenticateUsecase: inject(),
      iSignInUsecase: inject(),
      iSignUpUsecase: inject(),
    ),
  );

  inject.registerFactory(
    () => TaskController(
        iAddTaskUsecase: inject(),
        iDeleteTaskUsecase: inject(),
        iFindAllTaskUsecase: inject(),
        iUpdateTaskUsecase: inject()),
  );

  inject.registerLazySingleton(
    () => HomeController(
        iAddTodoUsecase: inject(),
        iDeleteTodoUsecase: inject(),
        iFindAllTodoUsecase: inject(),
        iUpdateTodoUsecase: inject()),
  );

  inject.registerLazySingleton(
    () => MainController(),
  );
}
