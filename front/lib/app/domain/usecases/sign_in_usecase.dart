import 'package:dartz/dartz.dart';
import 'package:todo/app/domain/entities/user_entity.dart';
import 'package:todo/app/domain/repositories/i_user_repository.dart';
import 'package:todo/app/domain/usecases/interfaces/user/i_sign_in_usecase.dart';
import 'package:todo/core/errors/i_business_exception.dart';

class SignInUsecase implements ISignInUsecase {
  IUserRepository iUserRepository;

  SignInUsecase({
    required this.iUserRepository,
  });

  @override
  Future<Either<IBusinessException, void>> call(UserEntity entity) async {
    if (entity.email.isEmpty) {
      return Left(ArgumentsException('email is required'));
    }

    if (entity.password.isEmpty) {
      return Left(ArgumentsException('password is required'));
    }

    return iUserRepository.signIn(entity);
  }
}
