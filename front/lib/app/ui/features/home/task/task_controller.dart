import 'package:flutter/cupertino.dart';
import 'package:todo/app/domain/entities/task_entity.dart';
import 'package:todo/app/domain/usecases/interfaces/task/i_add_task_usecase.dart';
import 'package:todo/app/domain/usecases/interfaces/task/i_delete_task_usecase.dart';
import 'package:todo/app/domain/usecases/interfaces/task/i_find_all_task_usecase.dart';
import 'package:todo/app/domain/usecases/interfaces/task/i_update_task_usecase.dart';
import 'package:todo/app/ui/controller_helper/error_helper_mixin.dart';

class TaskController extends ChangeNotifier with ErrorHelperMixin {
  final IAddTaskUsecase iAddTaskUsecase;
  final IDeleteTaskUsecase iDeleteTaskUsecase;
  final IUpdateTaskUsecase iUpdateTaskUsecase;
  final IFindAllTaskUsecase iFindAllTaskUsecase;

  ValueNotifier<List<TaskEntity>> tasks = ValueNotifier([]);

  final TextEditingController textFieldController = TextEditingController();
  final List<TaskEntity> suggestions = [];
  late int todoId;

  TaskController({
    required this.iAddTaskUsecase,
    required this.iDeleteTaskUsecase,
    required this.iUpdateTaskUsecase,
    required this.iFindAllTaskUsecase,
  });

  getEntity(int index) {
    return tasks.value[index];
  }

  void onInit() {
    loadAllTask();
  }

  loadAllTask() async {
    (await iFindAllTaskUsecase()).fold(
      onError,
      (r) {
        tasks.value = r.where((element) => element.todoId == todoId).toList();
      },
    );
  }

  addTask() {}

  deleteTask(int index) {}

  editTask() {}

  select(int index) {
    for (var element in tasks.value) {
      if (getEntity(index).id == element.id) {
        element.selected = !element.selected;
      } else {
        element.selected = false;
      }
    }

    tasks.notifyListeners();
  }
}
