import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:syrian_currency/core/constants/app_color.dart';
import 'package:syrian_currency/core/constants/app_text_style.dart';

class MyAppBar extends StatelessWidget {
  const MyAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          decoration: BoxDecoration(
            color: Color.fromRGBO(23, 30, 41, 68),

            border: Border.all(
              width: 0.05,
              color: Colors.grey.withOpacity(0.8),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 22.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SvgPicture.asset("assets/svgs/app_bar_logo.svg"),

                Text("Home", style: AppTextStyle.font20extrabold),

                Container(
                  width: 40.w,
                  height: 40.h,
                  decoration: BoxDecoration(
                    color: AppColor.blureColor.withOpacity(0.8),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.notifications, color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
