import 'package:dartz/dartz.dart';
import 'package:todo/core/errors/i_business_exception.dart';

abstract class ILoggedUsecase {
  Future<Either<IBusinessException, bool>> call();
}
