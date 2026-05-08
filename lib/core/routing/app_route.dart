import 'package:flutter/material.dart';
import 'package:syrian_currency/core/routing/routes.dart';
import 'package:syrian_currency/feature/auth/pages/login_screen.dart';
import 'package:syrian_currency/feature/auth/pages/signup_screen.dart';
import 'package:syrian_currency/feature/home/ui/home_screeen.dart';
import 'package:syrian_currency/feature/onbording/page_cntroller.dart';
import 'package:syrian_currency/feature/scan_result/ui/scan_result_screen.dart';

class AppRoute {
  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.pageCntroller:
        return MaterialPageRoute(builder: (_) => PageCntroller());
      case Routes.logIn:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case Routes.signUp:
        return MaterialPageRoute(builder: (_) => SignupScreen());
      case Routes.home:
        return MaterialPageRoute(builder: (_) => HomeScreeen());
      case Routes.scanResult:
        return MaterialPageRoute(builder: (_) => ScanResultScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
