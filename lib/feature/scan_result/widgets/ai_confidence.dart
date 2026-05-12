import 'dart:ui';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syrian_currency/core/constants/app_color.dart';
import 'package:syrian_currency/core/constants/app_text_style.dart';

class AiConfidence extends StatelessWidget {
  const AiConfidence({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      decoration: BoxDecoration(
        color: AppColor.mainContainerBackGround,
        borderRadius: BorderRadius.circular(48.r),
      ),
    
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 24.h),
          child: Column(
            children: [
              Text(
                "AI CONFIDENCE",
                style: AppTextStyle.font12semibold.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColor.grayText,
                ),
              ),
              16.verticalSpace,
              Center(
                child: DottedBorder(
                  options: CircularDottedBorderOptions(
                    dashPattern: [60, 30],
                    color: AppColor.blue,
                    strokeWidth: 9,
                  ),
                  child: Container(
                    width: 84.w,
                    height: 84.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        "98%",
                        style: AppTextStyle.font24bold,
                      ),
                    ),
                  ),
                ),
              ),
              16.verticalSpace,
              Text(
                "High precision neural matching complete",
                style: AppTextStyle.font12semibold.copyWith(
                  fontWeight: FontWeight.w500,
                  color: AppColor.grayText,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
