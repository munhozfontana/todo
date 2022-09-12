import 'dart:async';

import 'package:flutter/material.dart';
import 'package:todo/app/domain/entities/task_entity.dart';
import 'package:todo/app/domain/entities/todo_entity.dart';
import 'package:todo/app/domain/usecases/interfaces/task/i_add_task_usecase.dart';
import 'package:todo/app/domain/usecases/interfaces/task/i_delete_task_usecase.dart';
import 'package:todo/app/domain/usecases/interfaces/task/i_find_all_task_usecase.dart';
import 'package:todo/app/domain/usecases/interfaces/task/i_update_task_usecase.dart';
import 'package:todo/app/domain/usecases/interfaces/todo/i_find_one_todo_usecase.dart';
import 'package:todo/app/ui/controller_helper/error_helper_mixin.dart';

class TaskController extends ChangeNotifier with ErrorHelperMixin {
  final IAddTaskUsecase iAddTaskUsecase;
  final IDeleteTaskUsecase iDeleteTaskUsecase;
  final IUpdateTaskUsecase iUpdateTaskUsecase;
  final IFindAllTaskUsecase iFindAllTaskUsecase;
  final IFindOneTodoUsecase iFindOneTodoUsecase;

  ValueNotifier<List<TaskEntity>> tasks = ValueNotifier([]);
  ValueNotifier<List<DropdownMenuItem<TaskEntity>>> suggestions =
      ValueNotifier([]);

  final TextEditingController nameField = TextEditingController();

  int? todoId;
  ValueNotifier<TodoEntity?> todoEntity = ValueNotifier(null);

  TaskEntity? childTaskSelect;

  TaskEntity? selectEditTask;

  final GlobalKey<FormFieldState> key = GlobalKey<FormFieldState>();

  get isEdit => tasks.value.any((element) => element.selected);

  TaskController({
    required this.iAddTaskUsecase,
    required this.iDeleteTaskUsecase,
    required this.iUpdateTaskUsecase,
    required this.iFindAllTaskUsecase,
    required this.iFindOneTodoUsecase,
  });

  TaskEntity getEntity(int index) {
    return tasks.value[index];
  }

  void onInit() {
    loadAllTask();
    findTodoById();
  }

  Future<void> findTodoById() async {
    (await iFindOneTodoUsecase(todoId!)).fold(
      onError,
      (r) => todoEntity.value = r,
    );
  }

  loadAllTask() async {
    (await iFindAllTaskUsecase()).fold(
      onError,
      (r) {
        tasks.value.clear();
        tasks.value = r.where((element) => element.todoId == todoId).toList()
          ..sort((a, b) {
            int? hasFather;
            if (b.taskEntity != null) {
              hasFather = a.id! - b.taskEntity!.id!;
            }

            if (hasFather != null) {
              return hasFather;
            }

            return hasFather ?? a.id! - b.id!;
          });

        suggestions.value = tasks.value
            .where((element) => element.taskEntity == null)
            .map((e) => DropdownMenuItem<TaskEntity>(
                  value: e,
                  child: Text(e.name),
                ))
            .toList();

        suggestions.notifyListeners();
        tasks.notifyListeners();
      },
    );
  }

  addTask() async {
    if (nameField.text.isEmpty) {
      onMessage('Write something');
      return;
    }

    final entity = TaskEntity(
      name: nameField.text,
      todoId: todoId!,
      taskEntity: childTaskSelect,
    );
    (await iAddTaskUsecase(entity)).fold(
      onError,
      (r) {
        loadAllTask();
        clearForm();
      },
    );
  }

  void updateTask() async {
    if (nameField.text.isEmpty) {
      onMessage('Write something');
      return;
    }

    if (childTaskSelect?.id == selectEditTask!.id) {
      onMessage('Task should not child self');
      return;
    }

    final hasChild = tasks.value
        .where((element) => element.taskEntity != null)
        .where((element) => element.taskEntity!.id == selectEditTask!.id)
        .isNotEmpty;
    if (hasChild) {
      onMessage('This task have children');
      return;
    }

    final entity = TaskEntity(
      id: selectEditTask!.id,
      name: nameField.text,
      todoId: todoId!,
      taskEntity: childTaskSelect,
    );

    (await iUpdateTaskUsecase(entity)).fold(
      onError,
      (r) {
        loadAllTask();
        clearForm();
      },
    );
  }

  deleteTask(int index) async {
    (await iDeleteTaskUsecase(getEntity(index))).fold(
      onError,
      (r) {
        loadAllTask();
        clearForm();
      },
    );
  }

  select(int index) {
    for (var element in tasks.value) {
      if (getEntity(index).id == element.id) {
        element.selected = !element.selected;

        if (element.selected) {
          selectEditTask = element;
          nameField.text = element.name;

          if (element.taskEntity != null) {
            childTaskSelect = tasks.value
                .firstWhere((item) => item.id == element.taskEntity!.id);
            suggestions.notifyListeners();
          }
        } else {
          clearForm();
          suggestions.notifyListeners();
        }
      } else {
        element.selected = false;
      }
    }

    tasks.notifyListeners();
  }

  clearForm() {
    nameField.clear();
    key.currentState?.reset();
    childTaskSelect = null;
  }

  void onSelectTask(TaskEntity? value) {
    childTaskSelect = value;
    suggestions.notifyListeners();
  }
}
