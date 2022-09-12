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

  void onSubmit() {
    if (_controller.isEdit) {
      _controller.updateTask();
    } else {
      _controller.addTask();
    }
  }

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
        title: ValueListenableBuilder(
          valueListenable: _controller.todoEntity,
          builder: (_, value, child) {
            return Text(value?.name ?? '');
          },
        ),
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
          form(size, context),
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

  Widget itemTile(int index, TaskEntity entity, BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: entity.taskEntity == null ? 0 : 32),
      child: ListTile(
        tileColor: Colors.grey[200],
        onTap: () => _controller.select(index),
        selected: entity.selected,
        title: Text(entity.name),
        trailing: InkWell(
          child: const Icon(
            Icons.delete,
            size: 32,
          ),
          onTap: () => _controller.deleteTask(index),
        ),
      ),
    );
  }

  Widget form(Size size, BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 36),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
      ),
      child: Column(
        children: [
          ValueListenableBuilder(
            valueListenable: _controller.suggestions,
            builder: (_, value, child) {
              return DropdownButtonFormField<TaskEntity>(
                key: _controller.key,
                icon: _controller.childTaskSelect == null
                    ? const Icon(Icons.keyboard_arrow_down_outlined)
                    : InkWell(
                        onTap: () => _controller.onSelectTask(null),
                        child: const Icon(Icons.close),
                      ),
                decoration: InputDecoration(
                  labelText: _controller.childTaskSelect == null
                      ? 'Select the father'
                      : 'Selected',
                ),
                value: _controller.childTaskSelect,
                items: value,
                onChanged: _controller.onSelectTask,
              );
            },
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 56,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 3,
                  child: TextField(
                    controller: _controller.nameField,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ValueListenableBuilder(
                    valueListenable: _controller.tasks,
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
          ),
        ],
      ),
    );
  }
}
