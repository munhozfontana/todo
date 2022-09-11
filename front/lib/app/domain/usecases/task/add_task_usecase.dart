import 'package:dartz/dartz.dart';
import 'package:todo/app/domain/entities/task_entity.dart';
import 'package:todo/app/domain/repositories/i_task_repository.dart';
import 'package:todo/app/domain/usecases/interfaces/task/i_add_task_usecase.dart';
import 'package:todo/core/errors/i_business_exception.dart';

class AddTaskUsecase implements IAddTaskUsecase {
  final ITaskRepository iTaskRepository;

  AddTaskUsecase({
    required this.iTaskRepository,
  });

  @override
  Future<Either<IBusinessException, TaskEntity>> call(TaskEntity entity) {
    return iTaskRepository.add(entity);
  }
}
