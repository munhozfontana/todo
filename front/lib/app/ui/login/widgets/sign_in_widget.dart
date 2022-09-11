import 'package:flutter/material.dart';
import 'package:todo/app/domain/entities/user_entity.dart';
import 'package:todo/app/domain/entities/validators/email_validator.dart';
import 'package:todo/app/domain/entities/validators/password_validator.dart';

class SignInWidget extends StatefulWidget {
  final Function(UserEntity) onSubmit;
  final Function() toSignUpPage;

  const SignInWidget({
    Key? key,
    required this.onSubmit,
    required this.toSignUpPage,
  }) : super(key: key);

  @override
  State<SignInWidget> createState() => SignInWidgetState();
}

class SignInWidgetState extends State<SignInWidget> {
  late GlobalKey<FormState> formKey;

  FormState get form => formKey.currentState!;
  late UserEntity userEntity;

  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  void initState() {
    userEntity = UserEntity.empty();
    formKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 34),
        child: Column(
          children: [
            Expanded(
              child: Text(
                'Sign - in',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            Expanded(
              flex: 4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextFormField(
                    controller: emailController,
                    validator: EmailValidator(),
                    decoration: const InputDecoration(
                      hintText: 'e-mail',
                    ),
                  ),
                  TextFormField(
                    controller: passwordController,
                    validator: PasswordValidator(),
                    decoration: const InputDecoration(
                      hintText: 'password',
                    ),
                    obscureText: true,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      widget.onSubmit(UserEntity(
                        email: emailController.text,
                        password: passwordController.text,
                      ));
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.maxFinite, 46),
                    ),
                    child: const Text('Sign In'),
                  ),
                  OutlinedButton(
                    onPressed: widget.toSignUpPage,
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size(double.maxFinite, 46),
                    ),
                    child: const Text('Sign Up'),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
