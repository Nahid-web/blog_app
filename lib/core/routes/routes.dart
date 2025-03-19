import 'package:blog_app/core/pages/error_page.dart';
import 'package:blog_app/features/auth/presentation/pages/login_page.dart';
import 'package:blog_app/features/auth/presentation/pages/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RouteNames {
  static const String signUp = '/signup';
  static const String login = '/login';
}

// GoRouter Configuration
final GoRouter router = GoRouter(
  initialLocation: RouteNames.signUp,
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
  ],
  errorPageBuilder: (context, state) => MaterialPage(child: const ErrorPage()),
);
