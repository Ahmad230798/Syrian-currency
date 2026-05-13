import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syrian_currency/core/constants/app_color.dart';
import 'package:syrian_currency/core/constants/app_text_style.dart';
import 'package:syrian_currency/feature/onbording/widgets/on_boarding_header.dart';
import 'package:syrian_currency/feature/onbording/widgets/on_boarding_pic_holder.dart';

class OnBoarding3 extends StatelessWidget {
  const OnBoarding3({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const OnBoardingHeader(),
        SizedBox(height: 33.h),
        OnboardingPicHolder(
          color1: Color(0xFF3C83F6).withValues(alpha: 0.00),
          color2: Color(0xFF3C83F6).withValues(alpha: 0.1),
          hight: 224.h,
          imagePath: "assets/images/onboarding3image.png",
          isActive: true,
          fit: BoxFit.contain,
        ),
        SizedBox(height: 10.h),
        Text("Protect Your", style: AppTextStyle.font30extraBold),
        Text(
          "Transactions",
          style: AppTextStyle.font30extraBold.copyWith(color: AppColor.blue),
        ),
        SizedBox(height: 16.h),
        Text(
          "Real-time verification with\nexplainable AI to protect your assets.",
          style: AppTextStyle.font16medium.copyWith(
            fontWeight: FontWeight.w400,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
