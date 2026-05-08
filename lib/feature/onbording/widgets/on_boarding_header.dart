import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syrian_currency/core/constants/app_color.dart';
import 'package:syrian_currency/core/constants/app_text_style.dart';

class OnBoardingHeader extends StatelessWidget {
  const OnBoardingHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(Icons.shield_outlined, size: 40, color: AppColor.blue),
          // SizedBox(width: 80.w),
          Text("SYP Shield AI", style: AppTextStyle.font18bold),
          Text(
            "skip",
            style: AppTextStyle.font12semibold.copyWith(
              color: AppColor.grayText,
              fontSize: 16,
              height: 24 / 16,
            ),
          ),
        ],
      ),
    );
  }
}
