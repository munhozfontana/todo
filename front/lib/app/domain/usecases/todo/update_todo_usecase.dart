import 'package:dartz/dartz.dart';
import 'package:todo/app/domain/entities/todo_entity.dart';
import 'package:todo/app/domain/repositories/i_todo_repository.dart';
import 'package:todo/core/errors/i_business_exception.dart';

import '../interfaces/todo/i_update_todo_usecase.dart';

class UpdateTodoUsecase implements IUpdateTodoUsecase {
  final ITodoRepository iTodoRepository;

  UpdateTodoUsecase({
    required this.iTodoRepository,
  });

  @override
  Future<Either<IBusinessException, void>> call(TodoEntity entity) async {
    return iTodoRepository.update(entity);
  }
}
