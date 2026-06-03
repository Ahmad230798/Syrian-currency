import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// 🌟 تأكد من استيراد هذه الحزمة
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'package:syrian_currency/core/constants/app_color.dart';
import 'package:syrian_currency/core/constants/app_text_style.dart';
import 'package:syrian_currency/core/helper/navigation.dart';
import 'package:syrian_currency/core/networking/servicse.dart';
import 'package:syrian_currency/core/routing/routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // 🌟 1. إزالة شاشة النظام لكي يظهر تصميمك
    FlutterNativeSplash.remove();
    _checkUserRoleAndNavigate();
  }

  // 🌟 2. الكود بعد استخدام await وإضافة فحص المرة الأولى
  Future<void> _checkUserRoleAndNavigate() async {
    await Future.delayed(const Duration(seconds: 3));

    final SharedPreferencesService prefService = SharedPreferencesService();

    // جلب البيانات من الذاكرة المحلية
    final String? accessToken = await prefService.getAccessToken();

    if (!mounted) return;
    final String role = await prefService.getUserRole();
    if (accessToken != null || role == "guest") {
      // ✅ المستخدم لديه توكن (مسجل دخول أو زائر)

      if (role == "user") {
        await prefService.saveUserRole('user'); // تأكيد الصلاحية
        // توجيه الأدمن
        context.pushNamedAndRemoveUntil(Routes.mainLayout);
      } else {
        // توجيه المستخدم العادي والزائر (وأيضاً الخبير إذا وجد)
        if (role == "guest") {
          await prefService.saveUserRole('guest'); // تأكيد الصلاحية
        }
        context.pushNamedAndRemoveUntil(Routes.mainLayout);
      }
      if (role == "admin") {
        context.pushNamedAndRemoveUntil(Routes.adminDashboard);
      }
    } else {
      context.pushNamedAndRemoveUntil(Routes.pageCntroller);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0C1421),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            Positioned(top: -60, left: -60, child: _glow()),
            Positioned(bottom: -60, right: -60, child: _glow()),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),
                  Image.asset('assets/images/splash.png', width: 150.w),
                  32.verticalSpace,
                  Text("SYP SHIELD AI", style: AppTextStyle.font30extraBold),
                  8.verticalSpace,
                  Text(
                    "CYBER-SECURITY HUB",
                    style: AppTextStyle.font18bold.copyWith(
                      color: AppColor.blue,
                      letterSpacing: 1.5,
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                    height: 24.w,
                    width: 24.w,
                    child: const CircularProgressIndicator(
                      color: AppColor.blue,
                      strokeWidth: 2,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    "ENCRYPTING CONNECTION...",
                    style: AppTextStyle.font12semibold.copyWith(
                      color: AppColor.grayText,
                      letterSpacing: 1.5,
                    ),
                  ),
                  SizedBox(height: 48.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _glow() {
  return Container(
    width: 170,
    height: 200,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: Colors.white.withOpacity(0.00),
      boxShadow: [
        BoxShadow(
          color: Colors.white.withOpacity(0.15),
          blurRadius: 100,
          spreadRadius: 80,
        ),
      ],
    ),
  );
}
