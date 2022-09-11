import 'package:flutter/cupertino.dart';
import 'package:todo/app/domain/entities/todo_entity.dart';

class HomeController extends ChangeNotifier {
  final ValueNotifier<List<TodoEntity>> todoList = ValueNotifier([]);

  final TextEditingController textFieldController = TextEditingController();

  getInitialData() {}

  addTodoItem() {
    if (textFieldController.text.isNotEmpty) {
      todoList.value.add(TodoEntity(name: textFieldController.text));
      todoList.notifyListeners();
      clearForm();
    }
  }

  removeTodoItem(int index) {
    todoList.value.removeAt(index);
    todoList.notifyListeners();
  }

  editTodoItem(int index, String name) {
    todoList.value[index] = todoList.value[index].copyWith(name: name);
    todoList.notifyListeners();
  }

  clearForm() {
    textFieldController.clear();
  }
}
