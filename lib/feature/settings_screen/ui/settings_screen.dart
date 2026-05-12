import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syrian_currency/core/constants/app_color.dart';
import 'package:syrian_currency/core/constants/app_text_style.dart';
import 'package:syrian_currency/core/widgets/app_bottom.dart';
import 'package:syrian_currency/core/widgets/my_app_bar.dart';
import 'package:syrian_currency/core/widgets/profile_image_holder.dart';
import 'package:syrian_currency/feature/settings_screen/widgets/settings_options.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              MyAppBar(title: "Settings"),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      38.verticalSpace,
                      ProfileImageHolder(
                        imagePath: "assets/images/profile_image.png",
                        icon: Icons.verified_outlined,
                      ),
                      16.verticalSpace,
                      Text("Majd Khalifa", style: AppTextStyle.font30extraBold),
                      Text(
                        "Security Tier: Obsidian",
                        style: AppTextStyle.font16medium.copyWith(
                          color: AppColor.lightgray,
                          height: 19.6 / 16,
                          letterSpacing: 0,
                        ),
                      ),
                      32.verticalSpace,
                      SettingsOptions(),
                      32.verticalSpace,
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24.w),
                        child: AppBottom(
                          text: "Log Out",
                          boxShadow: [],
                          textcolor: AppColor.lightRed,
                          color: AppColor.lightRed,
                          backGroundColor: AppColor.lightRed.withOpacity(0.09),
                          icon: Icons.logout,
                        ),
                      ),
                      50.verticalSpace,
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
