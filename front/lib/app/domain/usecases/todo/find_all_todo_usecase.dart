import 'package:dartz/dartz.dart';
import 'package:todo/app/domain/entities/todo_entity.dart';
import 'package:todo/app/domain/repositories/i_todo_repository.dart';
import 'package:todo/core/errors/i_business_exception.dart';

import '../interfaces/todo/i_find_all_todo_usecase.dart';

class FindAllTodoUsecase implements IFindAllTodoUsecase {
  final ITodoRepository iTodoRepository;

  FindAllTodoUsecase({
    required this.iTodoRepository,
  });

  @override
  Future<Either<IBusinessException, List<TodoEntity>>> call() {
    return iTodoRepository.findAll();
  }
}
