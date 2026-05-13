import 'package:flutter/material.dart';
import 'package:syrian_currency/core/routing/routes.dart';
import 'package:syrian_currency/feature/AI%20Explanation/ai_explanation_screen.dart';
import 'package:syrian_currency/feature/about_project/about_project_screen.dart';
import 'package:syrian_currency/feature/auth/pages/login_screen.dart';
import 'package:syrian_currency/feature/auth/pages/signup_screen.dart';
import 'package:syrian_currency/feature/camera_scan/camera_scan_screen.dart';
import 'package:syrian_currency/feature/edite_profile/ui/edit_profile_screen.dart';
import 'package:syrian_currency/feature/home/ui/home_screeen.dart';
import 'package:syrian_currency/feature/onbording/page_cntroller.dart';
import 'package:syrian_currency/feature/profile/ui/profile_screen.dart';
import 'package:syrian_currency/feature/scan_history/ui/scan_history_screen.dart';
import 'package:syrian_currency/feature/scan_result/ui/scan_result_screen.dart';
import 'package:syrian_currency/feature/settings_screen/ui/settings_screen.dart';

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
      case Routes.profile:
        return MaterialPageRoute(builder: (_) => ProfileScreen());
      case Routes.editProfile:
        return MaterialPageRoute(builder: (_) => EditProfileScreen());
      case Routes.aiExplanation:
        return MaterialPageRoute(builder: (_) => AIExplanationScreen());
      case Routes.settingScreen:
        return MaterialPageRoute(builder: (_) => SettingsScreen());
      case Routes.scanHistoryScreen:
        return MaterialPageRoute(builder: (_) => ScanHistoryScreen());
      case Routes.aboutProject:
        return MaterialPageRoute(builder: (_) => AboutProjectScreen());
      case Routes.cameraScan:
        return MaterialPageRoute(builder: (_) => CameraScanScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
