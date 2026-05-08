import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:syrian_currency/core/constants/app_color.dart';
import 'package:syrian_currency/core/constants/app_text_style.dart';
import 'package:syrian_currency/feature/auth/widgets/login_form.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(top: -60, left: -60, child: _glow()),
          Positioned(bottom: -60, right: -60, child: _glow()),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                children: [
                  SvgPicture.asset("assets/svgs/logo.svg"),
                  SizedBox(height: 16.h),
                  Text("SYP Shield AI", style: AppTextStyle.font30extraBold),
                  SizedBox(height: 8.h),
                  Text(
                    "Securely access your AI-powered assets",
                    style: AppTextStyle.font16medium.copyWith(
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 40.h),
                  ClipRRect(
                    borderRadius: BorderRadiusGeometry.circular(18.r),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                      child: Container(
                        width: 1.sw,

                        color: AppColor.blureColor.withOpacity(0.4),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 32.w,
                            vertical: 30.h,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Welcome Back",
                                style: AppTextStyle.font24bold,
                              ),
                              SizedBox(height: 32),
                              LogInForm(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 50.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Dont have an account?",
                        style: AppTextStyle.font16medium.copyWith(
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      InkWell(
                        child: Text(
                          "Create an account",
                          style: AppTextStyle.font16medium.copyWith(
                            fontWeight: FontWeight.w400,
                            color: AppColor.blue,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
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
