import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/app/ui/widgets/btn_round_widget.dart';
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
        horizontal: size.width * .10,
      ),
      child: Stack(
        children: [
          listTodo(),
          form(size, context),
        ],
      ),
    );
  }

  Align form(Size size, BuildContext context) {
    return Align(
      alignment: const Alignment(-1.0, .85),
      child: Container(
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.25),
              )
            ],
            border: Border.all(
              color: Colors.white.withOpacity(0.2),
              width: 1.0,
            ),
            gradient: LinearGradient(
              colors: [
                Colors.white.withOpacity(0.5),
                Colors.white.withOpacity(0.2)
              ],
              stops: const [0.0, 1.0],
            ),
            borderRadius: BorderRadius.circular(50)),
        height: size.height * .1,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(width: 24),
            Expanded(
              flex: 9,
              child: TextField(
                controller: _controller.textFieldController,
              ),
            ),
            const SizedBox(width: 12),
            BtnRoundWidget(
              color: Theme.of(context).primaryColor,
              onLongPress: _controller.addTodoItem,
              onTap: () {
                var text = _controller.textFieldController.text;
                if (text.isNotEmpty) {
                  GoRouter.of(context).push('/home/todo/$text');
                }
              },
              child: const Center(child: Icon(Icons.add)),
            ),
            const SizedBox(width: 12),
            BtnRoundWidget(
              color: Colors.blueGrey,
              onTap: _controller.clearForm,
              child: const Icon(Icons.clear),
            ),
            const SizedBox(width: 24),
          ],
        ),
      ),
    );
  }

  AnimatedBuilder listTodo() {
    return AnimatedBuilder(
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
