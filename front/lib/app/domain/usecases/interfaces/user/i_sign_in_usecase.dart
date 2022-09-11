import 'package:dartz/dartz.dart';
import 'package:todo/app/domain/entities/user_entity.dart';
import 'package:todo/core/errors/i_business_exception.dart';

abstract class ISignInUsecase {
  Future<Either<IBusinessException, void>> call(UserEntity userEntity);
}
