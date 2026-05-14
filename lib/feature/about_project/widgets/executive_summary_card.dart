// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syrian_currency/core/constants/app_color.dart';
import 'package:syrian_currency/core/constants/app_text_style.dart';

class ExecutiveSummaryCard extends StatelessWidget {
  const ExecutiveSummaryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColor.mainContainerBackGround,
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "EXECUTIVE SUMMARY",
            style: AppTextStyle.font14regular.copyWith(
              color: AppColor.blue,
              letterSpacing: 1.5,
              fontWeight: FontWeight.w800,
            ),
          ),
          16.verticalSpace,
          Text(
            "SYP Shield AI is an academic research initiative focused on enhancing diagnostic accuracy in clinical settings. By utilizing Convolutional Neural Networks (CNN), the system provides automated analysis of medical imaging with visual interpretability.",
            style: AppTextStyle.font16medium.copyWith(
              color: AppColor.grayText,
              height: 1.6,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
