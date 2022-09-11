import 'package:dartz/dartz.dart';
import 'package:todo/app/domain/entities/task_entity.dart';
import 'package:todo/app/domain/repositories/i_task_repository.dart';
import 'package:todo/app/domain/usecases/interfaces/task/i_delete_task_usecase.dart';
import 'package:todo/core/errors/i_business_exception.dart';

class DeleteTaskUsecase implements IDeleteTaskUsecase {
  final ITaskRepository iTaskRepository;

  DeleteTaskUsecase({required this.iTaskRepository});

  @override
  Future<Either<IBusinessException, void>> call(TaskEntity entity) {
    return iTaskRepository.delete(entity.id!);
  }
}
