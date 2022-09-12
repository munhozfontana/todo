import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/app/domain/entities/todo_entity.dart';
import 'package:todo/injection.dart';

import 'home_controller.dart';

final _controller = inject<HomeController>();

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void onSubmit() {
    if (_controller.isEdit) {
      _controller.editTodoItem();
    } else {
      _controller.addTodoItem(context);
    }
  }

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
            child: ValueListenableBuilder(
              valueListenable: _controller.todoList,
              builder: (_, value, child) {
                return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor:
                          _controller.isEdit ? Colors.orange : null),
                  onPressed: onSubmit,
                  child: Text(
                    _controller.isEdit ? 'Edit' : 'Create',
                  ),
                );
              },
            ),
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
            itemBuilder: (context, index) {
              var entity = _controller.todoList.value[index];
              return itemTile(index, entity, context);
            },
            separatorBuilder: (context, index) => const SizedBox(
              height: 8,
            ),
            itemCount: _controller.todoList.value.length,
          );
        },
      ),
    );
  }

  ListTile itemTile(int index, TodoEntity entity, BuildContext context) {
    return ListTile(
        tileColor: Colors.grey[200],
        onTap: () => _controller.select(index),
        selected: entity.selected,
        title: Text(entity.name.toString()),
        trailing: SizedBox(
          height: double.maxFinite,
          width: 80,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: InkWell(
                  child: const Icon(
                    Icons.edit,
                    size: 32,
                  ),
                  onTap: () => GoRouter.of(context).push(
                    '/home/todo/${entity.id}',
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  child: const Icon(
                    Icons.delete,
                    size: 32,
                  ),
                  onTap: () => _controller.removeTodoItem(index),
                ),
              ),
            ],
          ),
        ));
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
