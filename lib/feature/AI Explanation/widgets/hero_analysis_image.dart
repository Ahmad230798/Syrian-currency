// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syrian_currency/core/constants/app_color.dart';
import 'package:syrian_currency/core/constants/app_text_style.dart';

class HeroAnalysisImage extends StatelessWidget {
  const HeroAnalysisImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 223.75.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(48.r),
        image: const DecorationImage(
          image: AssetImage("assets/images/syp.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24.r),
              color: Colors.black.withOpacity(0.2),
            ),
          ),
          Center(
            child: Container(
              width: 150.w,
              height: 150.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColor.blue.withOpacity(0.4),
                  width: 1.5,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 16.h,
            left: 16.w,
            child: Row(
              children: [
                const Icon(Icons.verified, color: AppColor.blue, size: 20),
                8.horizontalSpace,
                Text(
                  "SYP Shield AI",
                  style: AppTextStyle.font18bold.copyWith(color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
