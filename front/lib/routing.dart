import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/app/ui/features/home/about_app/about_app_page.dart';
import 'package:todo/app/ui/features/home/home_page.dart';
import 'package:todo/app/ui/features/home/home_page_tutorial.dart';
import 'package:todo/app/ui/features/home/todo/todo_page.dart';

final GoRouter router = GoRouter(
  routes: <GoRoute>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const HomePageTutorial();
      },
    ),
    GoRoute(
        path: '/home',
        builder: (BuildContext context, GoRouterState state) {
          return const HomePage();
        },
        routes: [
          GoRoute(
            path: 'todo/:new',
            builder: (BuildContext context, GoRouterState state) {
              return TodoPage(todoName: state.params['new']);
            },
          )
        ]),
    GoRoute(
      path: '/about_app_page',
      builder: (BuildContext context, GoRouterState state) {
        return const AboutAppPage();
      },
    ),
  ],
);
