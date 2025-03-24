import 'package:blog_app/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:blog_app/features/auth/presentation/pages/login_page.dart';
import 'package:blog_app/features/auth/presentation/pages/signup_page.dart';
import 'package:blog_app/features/blog/domain/entities/blog.dart';
import 'package:blog_app/features/blog/presentation/pages/add_new_blog_page.dart';
import 'package:blog_app/features/blog/presentation/pages/blog_page.dart';
import 'package:blog_app/features/blog/presentation/pages/blog_viewer_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class RouteNames {
  static const String signUp = '/signup';
  static const String login = '/login';
  static const String blog = '/blog';
  static const String blogAddNewBlog = '/blog/add_new_blog';
  static const String blogViewer = '/blog/viewer';
}

// GoRouter configuration
final GoRouter router = GoRouter(
  initialLocation: '/',
  redirect: (context, state) {
    final appUserCubit = context.read<AppUserCubit>();
    final isLoggedIn = appUserCubit.state is AppUserLoggeedIn;

    // If the user is trying to access the home route
    if (state.uri.path == '/') {
      // Redirect based on login status
      if (isLoggedIn) {
        return '/blog';
      } else {
        return '/login';
      }
    }

    // No redirect needed for other routes
    return null;
  },
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) {
        // This is a fallback if redirect doesn't work
        final appUserCubit = context.read<AppUserCubit>();
        final isLoggedIn = appUserCubit.state is AppUserLoggeedIn;

        if (isLoggedIn) {
          return const BlogPage();
        }
        return const LoginPage();
      },
    ),
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
    GoRoute(
      path: RouteNames.blogAddNewBlog,
      name: 'blogUpload',
      builder: (context, state) => const AddNewBlogPage(),
    ),
    GoRoute(
      path: RouteNames.blogViewer,
      name: 'blogViewer',
      builder: (context, state) {
        final blog = state.extra as Blog;
        return BlogViewerPage(blog: blog);
      },
    ),
  ],
  errorPageBuilder:
      (context, state) =>
          const MaterialPage(child: Center(child: Text("error"))),
);
