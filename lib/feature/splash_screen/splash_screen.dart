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

 Future<void> _checkUserRoleAndNavigate() async {
    await Future.delayed(const Duration(seconds: 3));

    final SharedPreferencesService prefService = SharedPreferencesService();

    // 1. جلب حالة الزيارة الأولى والتوكن والصلاحية من الذاكرة
    final bool isFirstTime = await prefService.isFirstTime(); 
    final String? accessToken = await prefService.getAccessToken();
    final String role = await prefService.getUserRole();

    if (!mounted) return;

    // 🌟 الجدار الأول: هل هذه أول مرة يفتح فيها التطبيق؟
    if (isFirstTime) {
      // ✅ نعم، أول مرة -> وجهه لشاشة الترحيب (Onboarding)
      context.pushNamedAndRemoveUntil(Routes.pageCntroller);
      
    } else {
      // ❌ لا، ليست المرة الأولى -> افحص التوكن والصلاحية
      
      if (accessToken != null || role == "guest") {
        // المستخدم لديه توكن أو مسجل كزائر
        if (role == "admin") {
          context.pushNamedAndRemoveUntil(Routes.adminDashboard);
        } else if (role == "user") {
          await prefService.saveUserRole('user');
          context.pushNamedAndRemoveUntil(Routes.mainLayout);
        } else {
          // للزائر (Guest) أو الخبير (Expert)
          if (role == "guest") {
            await prefService.saveUserRole('guest');
          }
          context.pushNamedAndRemoveUntil(Routes.mainLayout);
        }
      } else {
        // زار التطبيق سابقاً ولكنه لا يملك توكن (غير مسجل دخول) -> وجهه لتسجيل الدخول
        context.pushNamedAndRemoveUntil(Routes.logIn);
      }
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
