import 'package:dartz/dartz.dart';
import 'package:todo/app/data/external/interfaces/i_token_external.dart';
import 'package:todo/app/data/external/interfaces/i_user_external.dart';
import 'package:todo/app/data/models/user_model.dart';
import 'package:todo/app/domain/entities/user_entity.dart';
import 'package:todo/core/errors/i_business_exception.dart';

import '../../domain/repositories/i_user_repository.dart';

class UserRepository implements IUserRepository {
  final IUserExternal iUserExternal;
  final ITokenExternal iTokenExternal;

  UserRepository({
    required this.iUserExternal,
    required this.iTokenExternal,
  });

  @override
  Future<Either<IBusinessException, void>> signIn(UserEntity entity) async {
    try {
      var token = await iUserExternal.signIn(UserModel.fromEntity(entity));
      return Right(iTokenExternal.save(token));
    } on ExternalException catch (e) {
      return Left(ExternalException(e.message));
    } catch (e) {
      return Left(RepositoryException('Failed signIn at Repository'));
    }
  }

  @override
  Future<Either<IBusinessException, void>> signUp(UserEntity entity) async {
    try {
      return Right(await iUserExternal.signUp(UserModel.fromEntity(entity)));
    } on ExternalException catch (e) {
      return Left(ExternalException(e.message));
    } catch (e) {
      return Left(RepositoryException('Failed signUp at Repository'));
    }
  }

  @override
  Future<Either<IBusinessException, bool>> isAuthenticate() async {
    try {
      String? token = iTokenExternal.get();
      if (token == null) {
        return (const Right(false));
      }
      print(1);
      return (const Right(true));
    } on ExternalException catch (e) {
      return Left(ExternalException(e.message));
    } catch (e) {
      return Left(RepositoryException('Failed signUp at Repository'));
    }
  }
}
