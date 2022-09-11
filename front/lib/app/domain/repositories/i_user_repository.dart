import 'package:dartz/dartz.dart';
import 'package:todo/app/domain/entities/user_entity.dart';
import 'package:todo/core/errors/i_business_exception.dart';

abstract class IUserRepository {
  Future<Either<IBusinessException, void>> signIn(UserEntity entity);
  Future<Either<IBusinessException, void>> signUp(UserEntity entity);
  Future<Either<IBusinessException, bool>> isAuthenticate();
}
