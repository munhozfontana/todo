import 'package:dartz/dartz.dart';
import 'package:todo/app/domain/entities/todo_entity.dart';
import 'package:todo/core/errors/i_business_exception.dart';

abstract class ITodoRepository {
  Future<Either<IBusinessException, TodoEntity>> add(TodoEntity entity);
  Future<Either<IBusinessException, bool>> update(TodoEntity entity);
  Future<Either<IBusinessException, List<TodoEntity>>> findAll();
  Future<Either<IBusinessException, TodoEntity>> findOne(int id);
  Future<Either<IBusinessException, bool>> delete(int id);
}
