import 'package:dartz/dartz.dart';
import 'package:todo/app/data/external/interfaces/i_task_external.dart';
import 'package:todo/app/domain/entities/task_entity.dart';
import 'package:todo/core/errors/i_business_exception.dart';

import '../../domain/repositories/i_task_repository.dart';
import '../models/task_model.dart';

class TaskRepository implements ITaskRepository {
  final ITaskExternal iTaskExternal;

  TaskRepository({
    required this.iTaskExternal,
  });

  @override
  Future<Either<IBusinessException, TaskEntity>> add(TaskEntity entity) async {
    try {
      var id = await iTaskExternal.add(TaskModel.fromEntity(entity));
      var findModel = await iTaskExternal.findByOne(id);
      return Right(findModel.toEntity());
    } on ExternalException catch (e) {
      return Left(ExternalException(e.message));
    } catch (e) {
      return Left(RepositoryException('Failed add at TodoRepository'));
    }
  }

  @override
  Future<Either<IBusinessException, bool>> delete(int id) async {
    try {
      await iTaskExternal.delete(id);
      return const Right(true);
    } on ExternalException catch (e) {
      return Left(ExternalException(e.message));
    } catch (e) {
      return Left(RepositoryException('Failed add at TodoRepository'));
    }
  }

  @override
  Future<Either<IBusinessException, List<TaskEntity>>> findAll() async {
    try {
      final res = await iTaskExternal.findAll();
      return Right(res.map((e) => e.toEntity()).toList());
    } on ExternalException catch (e) {
      return Left(ExternalException(e.message));
    } catch (e) {
      return Left(RepositoryException('Failed add at TodoRepository'));
    }
  }

  @override
  Future<Either<IBusinessException, bool>> update(TaskEntity entity) async {
    try {
      var id = await iTaskExternal.update(TaskModel.fromEntity(entity));
      return Right(id);
    } on ExternalException catch (e) {
      return Left(ExternalException(e.message));
    } catch (e) {
      return Left(RepositoryException('Failed update at TodoRepository'));
    }
  }
}
