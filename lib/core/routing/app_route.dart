import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syrian_currency/core/networking/api_service.dart';
import 'package:syrian_currency/core/networking/dio_factory.dart';
import 'package:syrian_currency/core/networking/servicse.dart';
import 'package:syrian_currency/core/routing/routes.dart';
import 'package:syrian_currency/core/widgets/main_layout_screen.dart';
import 'package:syrian_currency/feature/AI%20Explanation/ai_explanation_screen.dart';
import 'package:syrian_currency/feature/about_project/about_project_screen.dart';
import 'package:syrian_currency/feature/admin_dashboard/admin_layout_screen.dart';
import 'package:syrian_currency/feature/admin_dashboard/logic/admin_cubit.dart';
import 'package:syrian_currency/feature/admin_dashboard/repo/admin_repo.dart';
import 'package:syrian_currency/feature/auth/logic/login/login_cubit.dart';
import 'package:syrian_currency/feature/auth/logic/register/signup_cubit.dart';
import 'package:syrian_currency/feature/auth/pages/login_screen.dart';
import 'package:syrian_currency/feature/auth/pages/signup_screen.dart';
import 'package:syrian_currency/feature/auth/repo/login_repo.dart';
import 'package:syrian_currency/feature/auth/repo/signup_repo.dart';
import 'package:syrian_currency/feature/camera_scan/camera_scan_screen.dart';
import 'package:syrian_currency/feature/camera_scan/logic/scanner_cubit.dart';
import 'package:syrian_currency/feature/camera_scan/model/scanner_response_model.dart';
import 'package:syrian_currency/feature/camera_scan/repo/scanner_repo.dart';
import 'package:syrian_currency/feature/edite_profile/logic/edite_profile_cubit.dart';
import 'package:syrian_currency/feature/edite_profile/repo/edit_profile_repo.dart';
import 'package:syrian_currency/feature/edite_profile/ui/edit_profile_screen.dart';
import 'package:syrian_currency/feature/home/ui/home_screeen.dart';
import 'package:syrian_currency/feature/onbording/page_cntroller.dart';
import 'package:syrian_currency/feature/profile/logic/profile_cubit.dart';
import 'package:syrian_currency/feature/profile/repo/profile_repo.dart';
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
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => LoginCubit(
              LoginRepo(
                ApiServices(DioFactory.getDio()),
                SharedPreferencesService(),
              ),
            ),
            child: LoginScreen(),
          ),
        );
      case Routes.signUp:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) =>
                SignupCubit(SignupRepo(ApiServices(DioFactory.getDio()))),
            child: SignupScreen(),
          ),
        );
      case Routes.home:
        return MaterialPageRoute(builder: (_) => HomeScreeen());
      case Routes.scanResult:
        // استقبال الداتا الممررة من شاشة الكاميرا
        final scanData = settings.arguments as ScanDataModel;
        return MaterialPageRoute(
          builder: (_) => ScanResultScreen(scanData: scanData),
        );
      case Routes.profile:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => ProfileCubit(
              repo: ProfileRepo(ApiServices(DioFactory.getDio())),
            )..getProfileInfo(),
            child: const ProfileScreen(isFromBottomNav: false),
          ),
        );
      case Routes.editProfile:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => EditeProfileCubit(
              EditProfileRepo(ApiServices(DioFactory.getDio())),
            )..getProfileInfo(),
            child: EditProfileScreen(),
          ),
        );
      case Routes.adminDashboard:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) =>
                AdminCubit(AdminRepo(ApiServices(DioFactory.getDio())))
                  ..fetchAllAdminData(), // 👈 جلب كل البيانات فور فتح الشاشة
            child: const AdminLayoutScreen(),
          ),
        );
      case Routes.aiExplanation:
        return MaterialPageRoute(builder: (_) => AIExplanationScreen());
      case Routes.settingScreen:
        return MaterialPageRoute(
          builder: (_) => SettingsScreen(isFromBottomNav: false),
        );
      case Routes.scanHistoryScreen:
        return MaterialPageRoute(
          builder: (_) => ScanHistoryScreen(isFromBottomNav: false),
        );
      case Routes.aboutProject:
        return MaterialPageRoute(builder: (_) => AboutProjectScreen());
      case Routes.cameraScan:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => ScannerCubit(
              ScannerRepo(
                ApiServices(DioFactory.getDio()),
                SharedPreferencesService(), // أضف هذا إذا كنت تستخدمه لمعرف الجهاز
              ),
            ),
            child: const CameraScanScreen(),
          ),
        );
      case Routes.mainLayout:
        return MaterialPageRoute(builder: (_) => const MainLayoutScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
