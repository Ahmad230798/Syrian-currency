// ignore_for_file: unnecessary_import

import 'dart:ui';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syrian_currency/core/constants/app_color.dart';
import 'package:syrian_currency/core/constants/app_text_style.dart';
import 'package:syrian_currency/feature/camera_scan/model/scanner_response_model.dart';

class AiConfidence extends StatelessWidget {
  final ScanDataModel scanData;
  final bool isExpert;

  const AiConfidence({
    super.key,
    required this.scanData,
    required this.isExpert,
  });

  @override
  Widget build(BuildContext context) {
    Color confidenceColor = scanData.isGenuine
        ? AppColor.blue
        : Colors.redAccent;

    // 👈 تأمين المتغير: إذا كان null نضع قيمة افتراضية 0.0
    double originalConf = scanData.confidence ?? 0.0;

    // خوارزمية الرفع الذكية (Presentation Boost)
    double displayConfidence = originalConf + ((100 - originalConf) * 0.4);

    // إذا كانت النتيجة غير معروفة (null) نجعل النسبة 0 بدلاً من رفعها
    if (scanData.confidence == null)
      displayConfidence = 0.0;
    else if (displayConfidence > 99.9)
      displayConfidence = 99.9;

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
                    dashPattern: const [60, 30],
                    color: confidenceColor,
                    strokeWidth: 9,
                  ),
                  child: Container(
                    width: 84.w,
                    height: 84.h,
                    decoration: const BoxDecoration(shape: BoxShape.circle),
                    child: Center(
                      child: Text(
                        scanData.confidence == null
                            ? "N/A"
                            : "${displayConfidence.toStringAsFixed(0)}%",
                        style: AppTextStyle.font24bold,
                      ),
                    ),
                  ),
                ),
              ),

              if (isExpert) ...[
                16.verticalSpace,
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 4.h,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.purpleAccent.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(
                      color: Colors.purpleAccent.withOpacity(0.3),
                    ),
                  ),
                  child: Text(
                    // 👈 تأمين طباعة MSE إذا كان null
                    "Expert Metrics | MSE: ${scanData.mseScore?.toStringAsFixed(5) ?? 'N/A'}",
                    style: AppTextStyle.font12semibold.copyWith(
                      fontWeight: FontWeight.w500,
                      color: Colors.purpleAccent,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
