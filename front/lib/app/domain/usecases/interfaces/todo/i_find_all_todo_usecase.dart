import 'package:dartz/dartz.dart';
import 'package:todo/app/domain/entities/todo_entity.dart';
import 'package:todo/core/errors/i_business_exception.dart';

abstract class IFindAllTodoUsecase {
  Future<Either<IBusinessException, List<TodoEntity>>> call();
}
