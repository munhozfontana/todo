import 'package:dartz/dartz.dart';
import 'package:todo/app/domain/entities/task_entity.dart';
import 'package:todo/core/errors/i_business_exception.dart';

abstract class IFindAllTaskUsecase {
  Future<Either<IBusinessException, List<TaskEntity>>> call();
}
