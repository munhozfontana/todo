import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/injection.dart';

import 'home_controller.dart';

final _controller = inject<HomeController>();

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: appBar(context),
      body: body(size, context),
    );
  }

  Padding body(Size size, BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: size.width * .20,
      ),
      child: Column(
        children: [
          form(size, context),
          const SizedBox(height: 18),
          listTodo(size),
        ],
      ),
    );
  }

  Widget form(Size size, BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 36),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
      ),
      height: size.height * .05,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 3,
            child: TextField(
              controller: _controller.textFieldController,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            flex: 1,
            child: ElevatedButton(
                onPressed: () {
                  var text = _controller.textFieldController.text;
                  _controller.addTodoItem();
                  // if () {
                  // GoRouter.of(context).push('/home/todo/$text');
                  // }
                },
                child: const Text('Create todo')),
          ),
        ],
      ),
    );
  }

  Widget listTodo(size) {
    return SizedBox(
      height: size.height * .5,
      child: AnimatedBuilder(
        animation: _controller.todoList,
        builder: (BuildContext context, Widget? child) {
          return ListView.separated(
            itemBuilder: (context, index) => ListTile(
              title: Text(_controller.todoList.value[index].name.toString()),
              trailing: InkWell(
                child: const Icon(Icons.delete),
                onTap: () => _controller.removeTodoItem(index),
              ),
            ),
            separatorBuilder: (context, index) => const SizedBox(
              height: 8,
            ),
            itemCount: _controller.todoList.value.length,
          );
        },
      ),
    );
  }

  AppBar appBar(BuildContext context) {
    return AppBar(
      title: const Text('Home'),
      actions: [
        SizedBox(
          width: 50,
          child: InkWell(
            onTap: () => GoRouter.of(context).push('/about_app_page'),
            child: const Icon(
              Icons.live_help_outlined,
              color: Colors.black,
            ),
          ),
        )
      ],
    );
  }
}
