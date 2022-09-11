import 'package:flutter/material.dart';
import 'package:todo/app/domain/entities/task_entity.dart';
import 'package:todo/app/ui/features/home/task/task_controller.dart';
import 'package:todo/injection.dart';

class TodoPage extends StatefulWidget {
  final String id;

  const TodoPage({
    super.key,
    required this.id,
  });

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  final TaskController _controller = inject<TaskController>();

  @override
  void initState() {
    _controller.todoId = int.parse(widget.id);
    _controller.onInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.id),
      ),
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
          // form(size, context),
          const SizedBox(height: 18),
          listTodo(size),
        ],
      ),
    );
  }

  Widget listTodo(size) {
    return SizedBox(
      height: size.height * .5,
      child: AnimatedBuilder(
        animation: _controller.tasks,
        builder: (BuildContext context, Widget? child) {
          return ListView.separated(
            itemBuilder: (context, index) {
              var entity = _controller.tasks.value[index];
              return itemTile(index, entity, context);
            },
            separatorBuilder: (context, index) => const SizedBox(
              height: 8,
            ),
            itemCount: _controller.tasks.value.length,
          );
        },
      ),
    );
  }

  ListTile itemTile(int index, TaskEntity entity, BuildContext context) {
    return ListTile(
      onTap: () => _controller.select(index),
      selected: entity.selected,
      title: Text(entity.name.toString()),
      trailing: SizedBox(
        height: double.maxFinite,
        width: 80,
        child: InkWell(
          child: const Icon(
            Icons.delete,
            size: 32,
          ),
          onTap: () => _controller.deleteTask(index),
        ),
      ),
    );
  }
}
