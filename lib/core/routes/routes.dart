import 'package:blog_app/core/pages/error_page.dart';
import 'package:blog_app/features/auth/presentation/pages/login_page.dart';
import 'package:blog_app/features/auth/presentation/pages/signup_page.dart';
import 'package:flutter/material.dart';

// Define route names as constants for better readability and maintainability
class RouteNames {
  static const String signUp = '/signup';
  static const String login = '/login';
}

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // Use RouteNames constants and the reusable _pageRouteBuilder function
      case RouteNames.signUp:
        return _pageRouteBuilder(const SignUpPage());
      case RouteNames.login:
        return _pageRouteBuilder(const LoginPage());
      // Consider handling null or unknown route names explicitly, though 'default' case covers most scenarios
      default:
        return _pageRouteBuilder(const ErrorPage());
    }
  }

  // Reusable function to create MaterialPageRoute
  static Route<dynamic> _pageRouteBuilder(Widget page) {
    return MaterialPageRoute(builder: (_) => page);
  }
}
