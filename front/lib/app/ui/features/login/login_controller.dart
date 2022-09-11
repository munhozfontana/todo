import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:todo/app/domain/entities/user_entity.dart';
import 'package:todo/app/domain/usecases/interfaces/user/i_logged_usecase.dart';
import 'package:todo/app/domain/usecases/interfaces/user/i_sign_in_usecase.dart';
import 'package:todo/app/domain/usecases/interfaces/user/i_sign_up_usecase.dart';
import 'package:todo/app/ui/controller_helper/error_helper_mixin.dart';

class LoginController with ErrorHelperMixin, ChangeNotifier {
  final ISignInUsecase iSignInUsecase;
  final ISignUpUsecase iSignUpUsecase;
  final ILoggedUsecase isAuthenticateUsecase;

  ValueNotifier<bool> isAuthenticate = ValueNotifier(true);

  LoginController({
    required this.iSignInUsecase,
    required this.iSignUpUsecase,
    required this.isAuthenticateUsecase,
  }) {
    _checkAuthentication();
    pageIndex.addListener(() {
      pageController.animateToPage(
        pageIndex.value,
        duration: const Duration(milliseconds: 700),
        curve: Curves.decelerate,
      );
    });
  }

  PageController pageController = PageController(
    initialPage: 0,
  );
  ValueNotifier<int> pageIndex = ValueNotifier(0);

  void signIn(UserEntity userEntity) async {
    (await iSignInUsecase(userEntity)).fold(
      onError,
      (r) => isAuthenticate.value = true,
    );
    notifyListeners();
  }

  void signUp(UserEntity userEntity) async {
    (await iSignUpUsecase(userEntity)).fold(
      onError,
      (r) => log('signUp success'),
    );
  }

  _checkAuthentication() async {
    (await isAuthenticateUsecase()).fold(
      onError,
      (r) => isAuthenticate.value = r,
    );
  }
}
