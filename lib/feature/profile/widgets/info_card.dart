import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syrian_currency/core/constants/app_color.dart';
import 'package:syrian_currency/core/constants/app_text_style.dart';

class InfoCard extends StatelessWidget {
  final String number;
  final String text;
  const InfoCard({super.key, required this.number, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 112.w,
      padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: AppColor.mainContainerBackGround,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              number,
              style: AppTextStyle.font24bold.copyWith(color: AppColor.blue),
            ),
            4.verticalSpace,
            Text(
              text,
              style: AppTextStyle.font10bold.copyWith(
                height: 15 / 10,
                letterSpacing: 1,

                color: AppColor.grayText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
