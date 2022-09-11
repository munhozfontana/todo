import 'package:flutter/material.dart';
import 'package:todo/app/ui/login/login_controller.dart';
import 'package:todo/app/ui/login/login_page.dart';
import 'package:todo/injection.dart';
import 'package:todo/routing.dart';

void main() {
  injection();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          inputDecorationTheme: const InputDecorationTheme(
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(
              vertical: 22,
              horizontal: 26,
            ),
          )),
      routeInformationProvider: router.routeInformationProvider,
      routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,
      builder: (context, child) {
        return Stack(
          children: [
            child!,
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
        );
      },
    );
  }
}
