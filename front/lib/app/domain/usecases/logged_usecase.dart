import 'package:dartz/dartz.dart';
import 'package:todo/app/domain/repositories/i_user_repository.dart';
import 'package:todo/core/errors/i_business_exception.dart';

import 'interfaces/user/i_logged_usecase.dart';

class LoggedUsecase implements ILoggedUsecase {
  final IUserRepository iUserRepository;

  LoggedUsecase({
    required this.iUserRepository,
  });

  @override
  Future<Either<IBusinessException, bool>> call() async {
    return iUserRepository.isAuthenticate();
  }
}
