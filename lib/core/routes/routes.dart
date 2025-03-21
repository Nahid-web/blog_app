import 'package:blog_app/features/auth/presentation/pages/login_page.dart';
import 'package:blog_app/features/auth/presentation/pages/signup_page.dart';
import 'package:blog_app/features/home/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RouteNames {
  static const String signUp = '/signup';
  static const String login = '/login';
  static const String home = '/home';
}

// GoRouter configuration
final GoRouter router = GoRouter(
  initialLocation: RouteNames.login,
  routes: [
    GoRoute(
      path: RouteNames.signUp,
      name: 'signUp',
      builder: (context, state) => const SignUpPage(),
    ),
    GoRoute(
      path: RouteNames.login,
      name: 'login',
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: RouteNames.home,
      name: 'home',
      builder: (context, state) => const HomePage(),
    ),
  ],
  errorPageBuilder:
      (context, state) =>
          const MaterialPage(child: Center(child: Text("error"))),
);
