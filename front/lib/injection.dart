import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:todo/app/data/external/api/user_external.dart';
import 'package:todo/app/data/external/cache/token_external.dart';
import 'package:todo/app/data/repositories/user_repository.dart';
import 'package:todo/app/domain/repositories/i_user_repository.dart';
import 'package:todo/app/domain/usecases/interfaces/user/i_logged_usecase.dart';
import 'package:todo/app/domain/usecases/interfaces/user/i_sign_in_usecase.dart';
import 'package:todo/app/domain/usecases/interfaces/user/i_sign_up_usecase.dart';
import 'package:todo/app/domain/usecases/logged_usecase.dart';
import 'package:todo/app/domain/usecases/sign_in_usecase.dart';
import 'package:todo/app/domain/usecases/sign_up_usecase.dart';
import 'package:todo/app/ui/home/home_controller.dart';
import 'package:todo/app/ui/home/todo/todo_controller.dart';
import 'package:todo/app/ui/login/login_controller.dart';
import 'package:todo/core/adapters/api_adapter.dart';

import 'app/data/external/interfaces/i_token_external.dart';
import 'app/data/external/interfaces/i_user_external.dart';
import 'core/adapters/i_api_adapter.dart';

final inject = GetIt.instance;

void injection() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.manual,
    overlays: SystemUiOverlay.values,
  );

  inject.registerFactory<IApiAdapter>(
    () => ApiAdapter(iTokenExternal: inject()),
  );

  inject.registerFactory<ITokenExternal>(
    () => TokenExternal(),
  );

  inject.registerFactory<IUserExternal>(
    () => UserExternal(
      iApiAdapter: inject(),
    ),
  );

  inject.registerFactory<IUserRepository>(
    () => UserRepository(
      iTokenExternal: inject(),
      iUserExternal: inject(),
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

  inject.registerLazySingleton(
    () => LoginController(
      isAuthenticateUsecase: inject(),
      iSignInUsecase: inject(),
      iSignUpUsecase: inject(),
    ),
  );

  inject.registerFactory(
    () => TodoController(),
  );

  inject.registerFactory(
    () => HomeController(),
  );
}
