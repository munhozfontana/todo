import 'package:dartz/dartz.dart';
import 'package:todo/app/domain/entities/todo_entity.dart';
import 'package:todo/app/domain/repositories/i_todo_repository.dart';
import 'package:todo/app/domain/usecases/interfaces/todo/i_find_one_todo_usecase.dart';
import 'package:todo/core/errors/i_business_exception.dart';

class FindOneTodoUsecase implements IFindOneTodoUsecase {
  final ITodoRepository iTodoRepository;
  FindOneTodoUsecase({
    required this.iTodoRepository,
  });

  @override
  Future<Either<IBusinessException, TodoEntity>> call(int id) async {
    return iTodoRepository.findOne(id);
  }
}
