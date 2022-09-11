import 'package:dartz/dartz.dart';
import 'package:todo/app/domain/entities/task_entity.dart';
import 'package:todo/app/domain/repositories/i_task_repository.dart';
import 'package:todo/app/domain/usecases/interfaces/task/i_find_all_task_usecase.dart';
import 'package:todo/core/errors/i_business_exception.dart';

class FindAllTaskUsecase implements IFindAllTaskUsecase {
  final ITaskRepository iTaskRepository;

  FindAllTaskUsecase({
    required this.iTaskRepository,
  });

  @override
  Future<Either<IBusinessException, List<TaskEntity>>> call() {
    return iTaskRepository.findAll();
  }
}
