import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:todo/app/ui/home/home_controller.dart';
import 'package:todo/app/ui/home/todo/todo_controller.dart';

final inject = GetIt.instance;

void injection() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.manual,
    overlays: SystemUiOverlay.values,
  );

  inject.registerFactory(
    () => TodoController(),
  );

  inject.registerFactory(
    () => HomeController(),
  );
}
