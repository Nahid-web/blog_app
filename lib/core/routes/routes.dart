import 'package:blog_app/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:blog_app/features/auth/presentation/pages/login_page.dart';
import 'package:blog_app/features/auth/presentation/pages/signup_page.dart';
import 'package:blog_app/features/blog/presentation/pages/blog_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class RouteNames {
  static const String signUp = '/signup';
  static const String login = '/login';
  static const String blog = '/blog';
}

// GoRouter configuration
final GoRouter router = GoRouter(
  initialLocation: RouteNames.login,
  redirect: (context, state) {
    final appUserState = BlocProvider.of<AppUserCubit>(context).state;

    if (appUserState is AppUserLoggeedIn) {
      if (state.uri.toString() != RouteNames.blog) {
        return RouteNames.blog;
      }
    } else {
      if (state.uri.toString() != RouteNames.login) {
        return RouteNames.login;
      }
    }
    return null;
  },
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
      path: RouteNames.blog,
      name: 'blog',
      builder: (context, state) => const BlogPage(),
    ),
  ],
  errorPageBuilder:
      (context, state) =>
          const MaterialPage(child: Center(child: Text("error"))),
);
