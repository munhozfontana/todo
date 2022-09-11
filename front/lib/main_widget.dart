import 'package:flutter/material.dart';
import 'package:todo/app/ui/features/login/login_controller.dart';
import 'package:todo/app/ui/features/login/login_page.dart';
import 'package:todo/injection.dart';

import 'main_controller.dart';

final _controller = inject<MainController>();

class MainWidget extends StatefulWidget {
  final Widget? child;

  const MainWidget({
    Key? key,
    this.child,
  }) : super(key: key);

  @override
  State<MainWidget> createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget> {
  @override
  void initState() {
    _controller.of().listen((event) {
      var snackBar = SnackBar(
        content: Text(event),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          widget.child!,
          ValueListenableBuilder(
            valueListenable: inject<LoginController>().isAuthenticate,
            builder: (_, value, child) {
              return Visibility(
                visible: !value,
                child: const LoginPage(),
              );
            },
          ),
        ],
      ),
    );
  }
}
