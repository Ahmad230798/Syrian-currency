// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syrian_currency/core/constants/app_color.dart';
import 'package:syrian_currency/core/constants/app_text_style.dart';

class TechStackGrid extends StatelessWidget {
  const TechStackGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _TechStackItem(
                icon: Icons.smartphone,
                title: "Flutter",
                subtitle: "Cross-platform UI",
              ),
            ),
            12.horizontalSpace,
            Expanded(
              child: _TechStackItem(
                icon: Icons.storage,
                title: "Django",
                subtitle: "Robust Backend",
              ),
            ),
          ],
        ),
        12.verticalSpace,
        Row(
          children: [
            Expanded(
              child: _TechStackItem(
                icon: Icons.psychology,
                title: "CNN",
                subtitle: "Classification",
              ),
            ),
            12.horizontalSpace,
            Expanded(
              child: _TechStackItem(
                icon: Icons.visibility,
                title: "Grad-CAM",
                subtitle: "Explainable AI",
              ),
            ),
          ],
        ),
      ],
    );
  }
}

/// عنصر مفرد داخل شبكة التقنيات (يبقى Private لأنه مستخدم فقط هنا)
class _TechStackItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _TechStackItem({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 12.w),
      decoration: BoxDecoration(
        color: AppColor.mainContainerBackGround,
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Column(
        children: [
          Container(
            width: 48.w,
            height: 48.w,
            decoration: BoxDecoration(
              color: AppColor.blue.withOpacity(0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: AppColor.blue, size: 24.sp),
          ),
          12.verticalSpace,
          Text(
            title,
            style: AppTextStyle.font14regular.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w800,
            ),
          ),
          4.verticalSpace,
          Text(
            subtitle,
            style: AppTextStyle.font12semibold.copyWith(
              color: AppColor.grayText,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
