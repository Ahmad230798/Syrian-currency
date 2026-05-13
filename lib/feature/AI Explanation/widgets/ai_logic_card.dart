// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syrian_currency/core/constants/app_color.dart';
import 'package:syrian_currency/core/constants/app_text_style.dart';

class AILogicCard extends StatelessWidget {
  const AILogicCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColor.mainContainerBackGround,
        borderRadius: BorderRadius.circular(48.r),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 360.h,
            decoration: BoxDecoration(
              color: AppColor.blureColor,
              borderRadius: BorderRadius.circular(32.r),
            ),
            child: Center(
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Icon(Icons.psychology, color: AppColor.blue, size: 55.sp),
                  Positioned(
                    top: -2,
                    right: -2,
                    child: Container(
                      width: 20.w,
                      height: 20.w,
                      decoration: BoxDecoration(
                        color: AppColor.green,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColor.backGroundColor,
                          width: 3,
                        ),
                      ),
                      child: Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 12.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          20.verticalSpace,
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: AppColor.blue.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  "HIGH CONFIDENCE",
                  style: AppTextStyle.font10bold.copyWith(color: AppColor.blue),
                ),
              ),
              12.horizontalSpace,
              Text(
                "ID: SYP-8842-X",
                style: AppTextStyle.font10bold.copyWith(
                  color: AppColor.grayText,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          16.verticalSpace,
          Text(
            "AI Detection Logic",
            style: AppTextStyle.font18bold.copyWith(fontSize: 20),
          ),
          12.verticalSpace,
          Text(
            "The neural network identified high-confidence markers in the holographic strip and intaglio printing areas. Comparison against known reference models shows zero variance.",
            style: AppTextStyle.font16medium.copyWith(height: 1.6),
          ),
          24.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "99.8%",
                    style: AppTextStyle.font24bold.copyWith(
                      color: AppColor.blue,
                    ),
                  ),
                  Text(
                    "CONFIDENCE SCORE",
                    style: AppTextStyle.font10bold.copyWith(
                      color: AppColor.grayText,
                      letterSpacing: 1,
                    ),
                  ),
                ],
              ),
              ElevatedButton.icon(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.blue,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(48.r),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 10.h,
                  ),
                ),
                icon: const Icon(Icons.visibility_outlined, size: 16),
                label: Text(
                  "View Heatmap\nDetails",
                  textAlign: TextAlign.center,
                  style: AppTextStyle.font14regular.copyWith(
                    color: Colors.white,
                    letterSpacing: 0,
                    height: 1.2,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
