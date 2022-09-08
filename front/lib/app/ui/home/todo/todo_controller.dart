import 'package:flutter/cupertino.dart';
import 'package:todo/app/domain/entites/task_entity.dart';

class TodoController {
  ValueNotifier<List<TaskEntity>> tasks = ValueNotifier([
    TaskEntity(name: '1', id: 1),
    TaskEntity(
      name: '2',
      id: 2,
      taskFather: [
        TaskEntity(name: '4', id: 4),
        TaskEntity(name: '5', id: 5),
      ],
    ),
    TaskEntity(name: '3', id: 3),
  ]);
}
