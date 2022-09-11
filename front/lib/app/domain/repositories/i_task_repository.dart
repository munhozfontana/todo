import 'package:dartz/dartz.dart';
import 'package:todo/app/domain/entities/task_entity.dart';
import 'package:todo/core/errors/i_business_exception.dart';

abstract class ITaskRepository {
  Future<Either<IBusinessException, TaskEntity>> add(TaskEntity entity);
  Future<Either<IBusinessException, bool>> update(TaskEntity entity);
  Future<Either<IBusinessException, List<TaskEntity>>> findAll();
  Future<Either<IBusinessException, bool>> delete(int id);
}
