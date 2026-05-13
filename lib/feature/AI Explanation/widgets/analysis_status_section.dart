import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syrian_currency/core/constants/app_color.dart';
import 'package:syrian_currency/core/constants/app_text_style.dart';

class AnalysisStatusSection extends StatelessWidget {
  const AnalysisStatusSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Analysis Complete",
          style: AppTextStyle.font24bold.copyWith(fontSize: 30),
        ),
        8.verticalSpace,
        Text(
          "Model focused on security thread and\nmicro-pattern regions.",
          textAlign: TextAlign.center,
          style: AppTextStyle.font18bold.copyWith(
            color: AppColor.grayText,
            height: 1.5,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
