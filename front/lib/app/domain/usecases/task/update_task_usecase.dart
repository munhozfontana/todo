import 'package:dartz/dartz.dart';
import 'package:todo/app/domain/entities/task_entity.dart';
import 'package:todo/app/domain/repositories/i_task_repository.dart';
import 'package:todo/app/domain/usecases/interfaces/task/i_update_task_usecase.dart';
import 'package:todo/core/errors/i_business_exception.dart';

class UpdateTaskUsecase implements IUpdateTaskUsecase {
  final ITaskRepository iTaskRepository;

  UpdateTaskUsecase({required this.iTaskRepository});

  @override
  Future<Either<IBusinessException, void>> call(TaskEntity entity) {
    return iTaskRepository.update(entity);
  }
}
