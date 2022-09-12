import 'package:dartz/dartz.dart';
import 'package:todo/app/data/external/interfaces/i_todo_external.dart';
import 'package:todo/app/data/models/todo_model.dart';
import 'package:todo/app/domain/entities/todo_entity.dart';
import 'package:todo/core/errors/i_business_exception.dart';

import '../../domain/repositories/i_todo_repository.dart';

class TodoRepository implements ITodoRepository {
  final ITodoExternal iTodoExternal;

  TodoRepository({
    required this.iTodoExternal,
  });

  @override
  Future<Either<IBusinessException, TodoEntity>> add(TodoEntity entity) async {
    try {
      var id = await iTodoExternal.add(TodoModel.fromEntity(entity));
      var findModel = await iTodoExternal.findByOne(id);
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
      await iTodoExternal.delete(id);
      return const Right(true);
    } on ExternalException catch (e) {
      return Left(ExternalException(e.message));
    } catch (e) {
      return Left(RepositoryException('Failed delete at TodoRepository'));
    }
  }

  @override
  Future<Either<IBusinessException, List<TodoEntity>>> findAll() async {
    try {
      final res = await iTodoExternal.findAll();
      return Right(res.map((e) => e.toEntity()).toList());
    } on ExternalException catch (e) {
      return Left(ExternalException(e.message));
    } catch (e) {
      return Left(RepositoryException('Failed findAll at TodoRepository'));
    }
  }

  @override
  Future<Either<IBusinessException, bool>> update(TodoEntity entity) async {
    try {
      var id = await iTodoExternal.update(TodoModel.fromEntity(entity));
      return Right(id);
    } on ExternalException catch (e) {
      return Left(ExternalException(e.message));
    } catch (e) {
      return Left(RepositoryException('Failed update at TodoRepository'));
    }
  }

  @override
  Future<Either<IBusinessException, TodoEntity>> findOne(int id) async {
    try {
      var model = await iTodoExternal.findByOne(id);
      return Right(model.toEntity());
    } on ExternalException catch (e) {
      return Left(ExternalException(e.message));
    } catch (e) {
      return Left(RepositoryException('Failed findOne at TodoRepository'));
    }
  }
}
