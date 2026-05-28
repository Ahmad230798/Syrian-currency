// ignore_for_file: unnecessary_import

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syrian_currency/core/constants/app_color.dart';
import 'package:syrian_currency/core/constants/app_text_style.dart';

class MenuItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final IconData suffixIcon;
  final Color suffixIconColor; // أضفنا هذا السطر

  const MenuItem({
    super.key,
    required this.icon,
    required this.text,
    required this.suffixIcon,
    this.suffixIconColor = AppColor.green, // القيمة الافتراضية
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 16.w),
      child: Row(
        children: [
          Icon(icon, color: AppColor.blue),
          12.horizontalSpace,
          Text(
            text,
            style: AppTextStyle.font14regular.copyWith(
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
          const Spacer(),
          Icon(suffixIcon, color: suffixIconColor), // استخدام اللون هنا
        ],
      ),
    );
  }
}
