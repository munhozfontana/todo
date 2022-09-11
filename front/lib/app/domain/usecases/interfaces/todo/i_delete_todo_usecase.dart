import 'package:dartz/dartz.dart';
import 'package:todo/core/errors/i_business_exception.dart';

abstract class IDeleteTodoUsecase {
  Future<Either<IBusinessException, void>> call();
}
