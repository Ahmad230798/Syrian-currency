// ignore_for_file: deprecated_member_use

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syrian_currency/core/constants/app_color.dart';
import 'package:syrian_currency/core/constants/app_text_style.dart';

class MyAppBar extends StatelessWidget {
  final String title;
  final Widget? suffixsIcon;
  final void Function()? onTap;
  final void Function()? onBackTap;
  final IconData? icon;
  final bool showRightIcon;

  const MyAppBar({
    super.key,
    required this.title,
    this.suffixsIcon,
    this.icon,
    this.showRightIcon = true,
    this.onTap,
    this.onBackTap,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color.fromRGBO(23, 30, 41, 0.68),
            border: Border.all(
              style: BorderStyle.solid,
              width: 1,
              strokeAlign: BorderSide.strokeAlignInside,
              color: Colors.white.withOpacity(0.08),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 22.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // 1. زر الرجوع (اليسار)
                InkWell(
                  onTap: onBackTap ?? () {},
                  child:
                      suffixsIcon ??
                      Icon(Icons.arrow_back, color: Colors.white, size: 30),
                ),

                // 2. العنوان (في المنتصف)
                Text(title, style: AppTextStyle.font20extrabold),

                // 3. الأيقونة اليمنى (مدمجة مع الـ InkWell والشرط)
                showRightIcon
                    ? InkWell(
                        onTap: onTap ?? () {},
                        child: Container(
                          width: 40.w,
                          height: 40.h,
                          decoration: BoxDecoration(
                            color: AppColor.blureColor.withOpacity(0.8),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            icon ?? Icons.shield_outlined,
                            color: Colors.white,
                          ),
                        ),
                      )
                    : SizedBox(
                        width: 40.w,
                      ), // صندوق فارغ للحفاظ على توسيط العنوان
              ],
            ),
          ),
        ),
      ),
    );
  }
}
