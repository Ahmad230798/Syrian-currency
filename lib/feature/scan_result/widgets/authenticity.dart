// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syrian_currency/core/constants/app_color.dart';
import 'package:syrian_currency/core/constants/app_text_style.dart';
import 'package:syrian_currency/feature/camera_scan/model/scanner_response_model.dart';

class Authenticity extends StatelessWidget {
  final ScanDataModel scanData;

  const Authenticity({super.key, required this.scanData});

  @override
  Widget build(BuildContext context) {
    bool isGenuine = scanData.isGenuine;
    Color resultColor = isGenuine ? AppColor.green : Colors.redAccent;

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
                "AUTHENTICITY",
                style: AppTextStyle.font12semibold.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColor.grayText,
                ),
              ),
              16.verticalSpace,
              Container(
                width: 64.w,
                height: 64.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: resultColor.withOpacity(0.2),
                  border: Border.all(
                    strokeAlign: 1,
                    color: resultColor.withOpacity(0.3),
                    style: BorderStyle.solid,
                    width: 3,
                  ),
                ),
                child: Center(
                  child: Icon(
                    isGenuine
                        ? Icons.verified_outlined
                        : Icons.gpp_bad_outlined,
                    color: resultColor,
                    size: 33,
                  ),
                ),
              ),
              8.verticalSpace,
              Text(
                isGenuine ? "GENUINE" : "COUNTERFEIT",
                style: AppTextStyle.font24bold.copyWith(color: resultColor),
              ),
              16.verticalSpace,
              Text(
                isGenuine
                    ? "All security features match federal reserve\nstandards"
                    : "Security anomaly detected in the note structures\nFailed AI verification",
                style: AppTextStyle.font12semibold.copyWith(
                  fontWeight: FontWeight.w500,
                  color: AppColor.grayText,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
