import 'package:flutter/material.dart';
import 'package:todo/app/ui/features/login/login_controller.dart';
import 'package:todo/app/ui/features/login/widgets/sign_in_widget.dart';
import 'package:todo/app/ui/features/login/widgets/sign_up_widget.dart';
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
                                SignInWidget(
                                  onSubmit: _controller.signIn,
                                  toSignUpPage: () {
                                    _controller.pageIndex.value = 1;
                                  },
                                ),
                                SignUpWidget(
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
