import 'package:dartz/dartz.dart';
import 'package:todo/app/domain/entities/user_entity.dart';
import 'package:todo/core/errors/i_business_exception.dart';

abstract class ISignUpUsecase {
  Future<Either<IBusinessException, void>> call(UserEntity userEntity);
}
