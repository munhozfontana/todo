import 'package:dartz/dartz.dart';
import 'package:todo/app/domain/entities/user_entity.dart';
import 'package:todo/app/domain/repositories/i_user_repository.dart';
import 'package:todo/app/domain/usecases/interfaces/user/i_sign_up_usecase.dart';
import 'package:todo/core/errors/i_business_exception.dart';

class SignUpUsecase implements ISignUpUsecase {
  IUserRepository iUserRepository;

  SignUpUsecase({
    required this.iUserRepository,
  });

  @override
  Future<Either<IBusinessException, void>> call(UserEntity entity) async {
    if (entity.email.value.isEmpty) {
      return Left(ArgumentsException('email is required'));
    }

    if (entity.password.value.isEmpty) {
      return Left(ArgumentsException('password is required'));
    }

    return iUserRepository.signUp(entity);
  }
}
