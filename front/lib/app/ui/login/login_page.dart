import 'package:flutter/material.dart';
import 'package:todo/app/domain/entities/user_entity.dart';
import 'package:todo/app/ui/login/login_controller.dart';
import 'package:todo/injection.dart';

final _controller = inject<LoginController>();

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Overlay(
      initialEntries: [
        OverlayEntry(
          builder: (context) => Container(
            color: Colors.black.withOpacity(.35),
            child: Center(
              child: Container(
                constraints: BoxConstraints(
                  minWidth: 350,
                  minHeight: 350,
                  maxWidth: size.height * .35,
                  maxHeight: size.height * .45,
                ),
                child: Overlay(
                  initialEntries: [
                    OverlayEntry(
                      builder: (context) => ValueListenableBuilder(
                        valueListenable: _controller.pageIndex,
                        builder: (_, pageIndex, child) {
                          return Scaffold(
                            body: PageView(
                              controller: _controller.pageController,
                              children: [
                                _SignInWidget(
                                  onSubmit: _controller.signIn,
                                  toSignUpPage: () {
                                    _controller.pageIndex.value = 1;
                                  },
                                ),
                                _SignUpWidget(
                                  onSubmit: _controller.signUp,
                                ),
                              ],
                            ),
                            bottomNavigationBar: BottomNavigationBar(
                              currentIndex: _controller.pageIndex.value,
                              onTap: (value) =>
                                  _controller.pageIndex.value = value,
                              items: const [
                                BottomNavigationBarItem(
                                  label: 'Sign In',
                                  icon: Icon(Icons.login_outlined),
                                ),
                                BottomNavigationBarItem(
                                  label: 'Sign Up',
                                  icon: Icon(Icons.new_label_outlined),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}

class _SignInWidget extends StatefulWidget {
  final Function(UserEntity) onSubmit;
  final Function() toSignUpPage;

  const _SignInWidget({
    Key? key,
    required this.onSubmit,
    required this.toSignUpPage,
  }) : super(key: key);

  @override
  State<_SignInWidget> createState() => _SignInWidgetState();
}

class _SignInWidgetState extends State<_SignInWidget> {
  late GlobalKey<FormState> formKey;
  FormState get form => formKey.currentState!;
  late UserEntity userEntity;

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
                    onChanged: userEntity.email.onChange,
                    validator: userEntity.email.validator,
                    decoration: const InputDecoration(
                      hintText: 'e-mail',
                    ),
                  ),
                  TextFormField(
                    onChanged: userEntity.password.onChange,
                    validator: userEntity.password.validator,
                    decoration: const InputDecoration(
                      hintText: 'password',
                    ),
                    obscureText: true,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (form.validate()) {
                        widget.onSubmit(userEntity);
                      }
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

class _SignUpWidget extends StatefulWidget {
  final Function(UserEntity) onSubmit;

  const _SignUpWidget({
    Key? key,
    required this.onSubmit,
  }) : super(key: key);

  @override
  State<_SignUpWidget> createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<_SignUpWidget> {
  late GlobalKey<FormState> formKey;
  FormState get form => formKey.currentState!;
  late UserEntity userEntity;

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
                    onChanged: userEntity.email.onChange,
                    validator: userEntity.email.validator,
                    decoration: const InputDecoration(
                      hintText: 'e-mail',
                    ),
                  ),
                  TextFormField(
                    onChanged: userEntity.password.onChange,
                    validator: userEntity.password.validator,
                    decoration: const InputDecoration(
                      hintText: 'password',
                    ),
                    obscureText: true,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (userEntity.password.value != value) {
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
                        widget.onSubmit(userEntity);
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
