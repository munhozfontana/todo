import 'package:dartz/dartz.dart';
import 'package:todo/app/domain/entities/task_entity.dart';
import 'package:todo/core/errors/i_business_exception.dart';

abstract class IUpdateTaskUsecase {
  Future<Either<IBusinessException, void>> call(TaskEntity entity);
}
