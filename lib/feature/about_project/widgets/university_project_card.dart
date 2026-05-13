// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syrian_currency/core/constants/app_color.dart';
import 'package:syrian_currency/core/constants/app_text_style.dart';

class UniversityProjectCard extends StatelessWidget {
  const UniversityProjectCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColor.blue.withOpacity(0.05), // خلفية زرقاء خفيفة جداً
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: AppColor.blue.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.school, color: AppColor.blue, size: 24.sp),
              12.horizontalSpace,
              Text("University Project", style: AppTextStyle.font18bold),
            ],
          ),
          16.verticalSpace,
          Text(
            "Presented as a final year capstone project, this research explores the intersection of medical science and machine learning to bridge the gap in diagnostic accessibility.",
            style: AppTextStyle.font14regular.copyWith(height: 1.6),
          ),
          20.verticalSpace,
          Divider(color: Colors.white.withOpacity(0.1), thickness: 1),
          16.verticalSpace,
          Row(
            children: [
              CircleAvatar(
                radius: 20.r,
                backgroundImage: const AssetImage(
                  "assets/images/profile_about_project.png",
                ),
                backgroundColor: AppColor.mainContainerBackGround,
              ),
              12.horizontalSpace,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Lead Researcher",
                    style: AppTextStyle.font14regular.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  2.verticalSpace,
                  Text(
                    "Dept. of Computer Science",
                    style: AppTextStyle.font12semibold.copyWith(
                      color: AppColor.grayText,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
