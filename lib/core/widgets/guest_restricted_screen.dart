import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syrian_currency/core/constants/app_color.dart';
import 'package:syrian_currency/core/constants/app_text_style.dart';
import 'package:syrian_currency/core/helper/navigation.dart';
import 'package:syrian_currency/core/networking/servicse.dart';
import 'package:syrian_currency/core/routing/routes.dart';
import 'package:syrian_currency/core/widgets/app_bottom.dart';
import 'package:syrian_currency/core/widgets/my_app_bar.dart';

class GuestRestrictedScreen extends StatelessWidget {
  final String title;
  final IconData icon;

  const GuestRestrictedScreen({
    super.key,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent, // لكي تعمل مع IndexedStack بسلاسة
      body: SafeArea(
        child: Column(
          children: [
            MyAppBar(
              title: title,
              showRightIcon: false,
              suffixsIcon: const SizedBox(), // إخفاء زر الرجوع
            ),
            Expanded(
              child: Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.all(24.w),
                        decoration: BoxDecoration(
                          color: AppColor.blue.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(icon, size: 60.sp, color: AppColor.blue),
                      ),
                      24.verticalSpace,
                      Text(
                        "Login Required",
                        style: AppTextStyle.font20extrabold,
                      ),
                      12.verticalSpace,
                      Text(
                        "You are browsing as a guest. To access your $title, please log in or create an account.",
                        textAlign: TextAlign.center,
                        style: AppTextStyle.font14regular.copyWith(
                          color: AppColor.grayText,
                          height: 1.5,
                        ),
                      ),
                      40.verticalSpace,
                      AppBottom(
                        text: "Sign In / Sign Up",
                        icon: Icons.login,
                        onPressed: () async {
                          final pref = SharedPreferencesService();
                          await pref.clearTokens();
                          if (context.mounted) {
                            context.pushNamedAndRemoveUntil(Routes.logIn);
                          }
                        },
                      ),
                      100.verticalSpace, // مساحة سفلية لرفع المحتوى فوق الـ Nav Bar
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
