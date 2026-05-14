// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syrian_currency/core/constants/app_color.dart';
import 'package:syrian_currency/core/constants/app_text_style.dart';

class DetailedMetricsSection extends StatelessWidget {
  const DetailedMetricsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: MetricItemCard(
            icon: Icons.fingerprint,
            title: "Micro-patterns",
            value: "Authentic Match",
          ),
        ),
        16.horizontalSpace,
        const Expanded(
          child: MetricItemCard(
            icon: Icons.texture,
            title: "Paper Texture",
            value: "Verified Fiber",
          ),
        ),
      ],
    );
  }
}

// قمت بإنشاء Widget منفصل للـ Item ليسهل استخدامه
class MetricItemCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const MetricItemCard({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
      decoration: BoxDecoration(
        color: AppColor.mainContainerBackGround,
        borderRadius: BorderRadius.circular(48.r),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppColor.blue, size: 24.sp),
          16.verticalSpace,
          Text(
            title.toUpperCase(),
            style: AppTextStyle.font10bold.copyWith(color: AppColor.grayText),
          ),
          6.verticalSpace,
          Text(
            value,
            style: AppTextStyle.font14regular.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
