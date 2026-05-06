import 'package:flutter/material.dart';
import 'package:syrian_currency/core/routing/routes.dart';
import 'package:syrian_currency/feature/auth/pages/login_screen.dart';
import 'package:syrian_currency/feature/onbording/page_cntroller.dart';

class AppRoute {
  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.pageCntroller:
        return MaterialPageRoute(builder: (_) => PageCntroller());
      case Routes.logIn:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
