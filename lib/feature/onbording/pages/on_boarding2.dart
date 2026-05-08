import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syrian_currency/core/constants/app_color.dart';
import 'package:syrian_currency/core/constants/app_text_style.dart';
import 'package:syrian_currency/feature/onbording/widgets/on_boarding_header.dart';

class OnBoarding2 extends StatelessWidget {
  const OnBoarding2({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        OnBoardingHeader(),
        SizedBox(height: 33.h),
        Container(
          height: 340.h,
          width: 340.w,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.white.withOpacity(0.04)),
            gradient: RadialGradient(
              center: Alignment.center,
              radius: 0.75,
              tileMode: TileMode.decal,
              colors: [
                Color(0xFF3C83F6).withOpacity(0.20),
                Color(0xFF3C83F6).withOpacity(0.08),
                Colors.transparent,
              ],
              stops: [0.0, 0.45, 1.0],
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 50.h, horizontal: 50.h),
            child: Align(
              alignment: Alignment.centerRight,
              child: Image.asset("assets/images/onboarding2image.png"),
            ),
          ),
        ),
        SizedBox(height: 10.h),
        Text("Fast.Accurate.", style: AppTextStyle.font30extraBold),
        Text(
          "Secure.",
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
