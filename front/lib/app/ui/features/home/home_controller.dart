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
    await loadAll();
  }

  Future<void> loadAll() async {
    (await iFindAllTodoUsecase()).fold(
      onError,
      (r) => todoList.value = r,
    );
  }

  Future<bool> addTodoItem() async {
    if (textFieldController.text.isNotEmpty) {
      var todoEntity = TodoEntity(name: textFieldController.text);
      (await iAddTodoUsecase(todoEntity)).fold(
        onError,
        (r) {
          todoList.value.add(todoEntity);
          todoList.notifyListeners();
          clearForm();
        },
      );

      return true;
    }
    return false;
  }

  removeTodoItem(int index) async {
    var entityToRemove = todoList.value.elementAt(index);
    (await iDeleteTodoUsecase(entityToRemove)).fold(
      onError,
      (r) {
        todoList.value.removeWhere(
          (element) => element.id == entityToRemove.id,
        );
      },
    );

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
