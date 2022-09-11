import 'package:dartz/dartz.dart';
import 'package:todo/app/domain/entities/todo_entity.dart';
import 'package:todo/app/domain/repositories/i_todo_repository.dart';
import 'package:todo/core/errors/i_business_exception.dart';

import '../interfaces/todo/i_add_todo_usecase.dart';

class AddTodoUsecase implements IAddTodoUsecase {
  final ITodoRepository iTodoRepository;

  AddTodoUsecase({
    required this.iTodoRepository,
  });

  @override
  Future<Either<IBusinessException, TodoEntity>> call(TodoEntity entity) {
    return iTodoRepository.add(entity);
  }
}
