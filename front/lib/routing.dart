import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/app/ui/presentation/presentation_page.dart';

final GoRouter router = GoRouter(
  routes: <GoRoute>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const PresentationPage();
      },
    ),
  ],
);
