import 'package:flutter/material.dart';
import 'package:todo/app/domain/entities/task_entity.dart';
import 'package:todo/app/ui/home/todo/todo_controller.dart';
import 'package:todo/app/ui/widgets/btn_round_widget.dart';
import 'package:todo/injection.dart';

final _controller = inject<TodoController>();

class TodoPage extends StatelessWidget {
  final String? todoName;
  const TodoPage({Key? key, this.todoName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(todoName ?? ''),
      ),
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
            DropdownButton<TaskEntity>(
              items: const [],
              onChanged: _controller.onChangeSelector,
            ),
            const SizedBox(width: 12),
            BtnRoundWidget(
              color: Theme.of(context).primaryColor,
              onTap: _controller.addTask,
              child: const Center(child: Icon(Icons.add)),
            ),
            const SizedBox(width: 24),
          ],
        ),
      ),
    );
  }

  AnimatedBuilder listTodo() {
    return AnimatedBuilder(
      animation: _controller.tasks,
      builder: (BuildContext context, Widget? child) {
        return ListView.separated(
          itemBuilder: (context, index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                item(_controller.tasks.value[index]),
                _controller.tasks.value[index].taskFather != null
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: _controller.tasks.value[index].taskFather!
                            .map((e) => LayoutBuilder(
                                  builder: (_, constrains) {
                                    return Container(
                                      margin: const EdgeInsets.only(top: 8),
                                      width: constrains.maxWidth * .90,
                                      child: item(e),
                                    );
                                  },
                                ))
                            .toList(),
                      )
                    : const SizedBox.shrink(),
              ],
            );
          },
          separatorBuilder: (context, index) => const SizedBox(
            height: 8,
          ),
          itemCount: _controller.tasks.value.length,
        );
      },
    );
  }

  Container item(TaskEntity task) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 238, 238, 238),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        title: Text(task.name.toString()),
        trailing: const InkWell(
          child: Icon(Icons.delete),
          // onTap: () => _controller.removeTodoItem(index),
        ),
      ),
    );
  }
}
