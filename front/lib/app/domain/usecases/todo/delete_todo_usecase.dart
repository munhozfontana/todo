import 'package:dartz/dartz.dart';
import 'package:todo/app/domain/entities/todo_entity.dart';
import 'package:todo/app/domain/repositories/i_todo_repository.dart';
import 'package:todo/core/errors/i_business_exception.dart';

import '../interfaces/todo/i_delete_todo_usecase.dart';

class DeleteTodoUsecase implements IDeleteTodoUsecase {
  final ITodoRepository iTodoRepository;

  DeleteTodoUsecase({
    required this.iTodoRepository,
  });

  @override
  Future<Either<IBusinessException, void>> call(TodoEntity entity) {
    return iTodoRepository.delete(entity.id!);
  }
}
