import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syrian_currency/core/constants/app_color.dart';
import 'package:syrian_currency/core/constants/app_text_style.dart';

class ActivityCard extends StatelessWidget {
  final IconData icon;
  final Color? iconColor;
  const ActivityCard({super.key, required this.icon, this.iconColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Container(
        width: 1.sw,
        decoration: BoxDecoration(
          color: AppColor.mainContainerBackGround,
          borderRadius: BorderRadius.circular(32),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 16.h),
          child: Row(
            children: [
              CircleAvatar(backgroundColor: AppColor.gray),
              SizedBox(width: 16.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Profile_Photo_Scan.jpg",
                    style: AppTextStyle.font14regular.copyWith(
                      fontWeight: FontWeight.w600,
                      height: 20 / 14,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "Completed • 2m ago",
                    style: AppTextStyle.font12semibold.copyWith(
                      fontWeight: FontWeight.w400,
                      color: AppColor.grayText,
                    ),
                  ),
                ],
              ),
              Spacer(),
              Icon(icon, color: iconColor ?? Colors.green),
            ],
          ),
        ),
      ),
    );
  }
}
