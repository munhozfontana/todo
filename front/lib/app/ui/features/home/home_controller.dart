import 'package:flutter/cupertino.dart';
import 'package:todo/app/domain/entities/todo_entity.dart';
import 'package:todo/app/domain/usecases/interfaces/todo/i_add_todo_usecase.dart';
import 'package:todo/app/domain/usecases/interfaces/todo/i_delete_todo_usecase.dart';
import 'package:todo/app/domain/usecases/interfaces/todo/i_find_all_todo_usecase.dart';
import 'package:todo/app/domain/usecases/interfaces/todo/i_update_todo_usecase.dart';
import 'package:todo/app/ui/controller_helper/error_helper_mixin.dart';

class HomeController extends ChangeNotifier with ErrorHelperMixin {
  final IAddTodoUsecase iAddTodoUsecase;
  final IDeleteTodoUsecase iDeleteTodoUsecase;
  final IUpdateTodoUsecase iUpdateTodoUsecase;
  final IFindAllTodoUsecase iFindAllTodoUsecase;

  HomeController({
    required this.iAddTodoUsecase,
    required this.iDeleteTodoUsecase,
    required this.iUpdateTodoUsecase,
    required this.iFindAllTodoUsecase,
  }) {
    getInitialData();
  }

  final ValueNotifier<List<TodoEntity>> todoList = ValueNotifier([]);
  final TextEditingController textFieldController = TextEditingController();

  getInitialData() async {
    (await iFindAllTodoUsecase()).fold(
      onError,
      (r) => todoList.value = r,
    );
  }

  bool addTodoItem() {
    if (textFieldController.text.isNotEmpty) {
      todoList.value.add(TodoEntity(name: textFieldController.text));
      todoList.notifyListeners();
      clearForm();
      return true;
    }
    return false;
  }

  removeTodoItem(int index) {
    todoList.value.removeAt(index);
    todoList.notifyListeners();
  }

  editTodoItem(int index, String name) {
    todoList.value[index].name = name;
    todoList.notifyListeners();
  }

  clearForm() {
    textFieldController.clear();
  }
}
