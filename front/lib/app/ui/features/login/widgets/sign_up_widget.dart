import 'package:flutter/material.dart';
import 'package:todo/app/domain/entities/user_entity.dart';
import 'package:todo/app/domain/entities/validators/email_validator.dart';
import 'package:todo/app/domain/entities/validators/password_validator.dart';

class SignUpWidget extends StatefulWidget {
  final Function(UserEntity) onSubmit;

  const SignUpWidget({
    Key? key,
    required this.onSubmit,
  }) : super(key: key);

  @override
  State<SignUpWidget> createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget> {
  late GlobalKey<FormState> formKey;
  FormState get form => formKey.currentState!;
  late UserEntity userEntity;

  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  void initState() {
    formKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
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
                'Sign - Up',
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
                  TextFormField(
                    validator: (value) {
                      if (passwordController.text != value) {
                        return 'Password should be equals';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      hintText: 'confirm password',
                    ),
                    obscureText: true,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.maxFinite, 46),
                    ),
                    onPressed: () {
                      if (form.validate()) {
                        widget.onSubmit(UserEntity(
                          email: emailController.text,
                          password: passwordController.text,
                        ));
                        emailController.clear();
                        passwordController.clear();
                      }
                    },
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
