import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syrian_currency/core/constants/app_colore.dart';
import 'package:syrian_currency/core/constants/app_text_style.dart';
import 'package:syrian_currency/feature/onbording/widgets/on_boarding_header.dart';
import 'package:syrian_currency/feature/onbording/widgets/on_boarding_pic_holder.dart';

class OnBoarding1 extends StatelessWidget {
  const OnBoarding1({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        OnBoardingHeader(),
        OnboardingPicHolder(
          imagePath: 'assets/images/onboarding_1image.png',
          isActive: false,
        ),
        SizedBox(height: 5.h),
        Text(
          "AI-Powered Banknote",
          style: AppTextStyle.font30extraBold,
          textAlign: TextAlign.center,
        ),
        Text(
          "Verification",
          style: AppTextStyle.font30extraBold.copyWith(color: AppColore.blue),
        ),
        SizedBox(height: 16.h),
        Text(
          "Detect counterfeit Syrian banknotes\ninstantly using advanced deep learning\nalgorithms.",
          style: AppTextStyle.font16medium.copyWith(
            fontWeight: FontWeight.w400,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
