import 'package:dartz/dartz.dart';
import 'package:todo/app/domain/entities/task_entity.dart';
import 'package:todo/core/errors/i_business_exception.dart';

abstract class IAddTaskUsecase {
  Future<Either<IBusinessException, TaskEntity>> call(TaskEntity entity);
}
