import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syrian_currency/core/constants/app_color.dart';
import 'package:syrian_currency/core/constants/app_text_style.dart';

class OptionsCard extends StatelessWidget {
  final Widget widget;
  final String text;
  final Widget? icon;
  const OptionsCard({
    super.key,
    required this.widget,
    required this.text,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        color: AppColor.mainContainerBackGround,
      ),
      child: Row(
        children: [
          widget,
          12.horizontalSpace,
          Text(
            text,
            style: AppTextStyle.font16medium.copyWith(
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          Spacer(),
          icon ??
              Icon(Icons.arrow_forward_ios, color: AppColor.grayText, size: 15),
        ],
      ),
    );
  }
}
