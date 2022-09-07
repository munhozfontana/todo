import 'package:flutter/material.dart';
import 'package:todo/app/ui/home/todo/todo_controller.dart';
import 'package:todo/injection.dart';

final _controller = inject<TodoController>();

class TodoPage extends StatelessWidget {
  final String? todoName;
  const TodoPage({Key? key, this.todoName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(todoName ?? ''),
      ),
      body: Container(),
    );
  }
}
