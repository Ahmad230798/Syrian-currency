// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syrian_currency/core/constants/app_color.dart';
import 'package:syrian_currency/core/constants/app_text_style.dart';

class ProjectHeroCard extends StatelessWidget {
  const ProjectHeroCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 240.h,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32.r),
        image: const DecorationImage(
          image: AssetImage("assets/images/about_project.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32.r),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.transparent,
              AppColor.backGroundColor.withOpacity(0.9),
            ],
          ),
        ),
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: AppColor.blue,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Text(
                "RESEARCH 2024",
                style: AppTextStyle.font12semibold.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            12.verticalSpace,
            Text(
              "SYP Shield AI",
              style: AppTextStyle.font24bold.copyWith(fontSize: 30.sp),
            ),
            4.verticalSpace,
            Text(
              "Deep Learning for Medical Diagnostics",
              style: AppTextStyle.font14regular.copyWith(
                color: Colors.white.withOpacity(0.7),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
