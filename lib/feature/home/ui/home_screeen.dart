import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syrian_currency/core/constants/app_color.dart';
import 'package:syrian_currency/core/constants/app_text_style.dart';
import 'package:syrian_currency/core/widgets/app_bottom.dart';
import 'package:syrian_currency/core/widgets/my_app_bar.dart';
import 'package:syrian_currency/feature/home/widget/activities_list.dart';

class HomeScreeen extends StatelessWidget {
  const HomeScreeen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            MyAppBar(),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Column(
                    children: [
                      SizedBox(height: 24.h),
                      ClipRRect(
                        borderRadius: BorderRadiusGeometry.circular(32.r),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 22.w,
                              vertical: 24.h,
                            ),
                            width: 1.sw,

                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(32.r),
                              color: Color.fromRGBO(30, 50, 90, 120),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "PROTECTION ACTIVATE",
                                  style: AppTextStyle.font12semibold.copyWith(
                                    fontWeight: FontWeight.w700,
                                    color: AppColor.blue,
                                    letterSpacing: 1.2,
                                  ),
                                ),
                                SizedBox(height: 8.h),
                                Text(
                                  "Secure your digital\npresence",
                                  style: AppTextStyle.font24bold,
                                ),
                                SizedBox(height: 6.h),
                                Text(
                                  "Our advanced AI engine detects deepfakes and\npotential content manipulation in seconds.",
                                  style: AppTextStyle.font14regular,
                                ),
                                SizedBox(height: 24.h),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(24.r),
                                  ),
                                  child: Image.asset(
                                    "assets/images/home_image.png",
                                  ),
                                ),
                                SizedBox(height: 24.h),
                                AppBottom(text: "Start System Scan"),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 22.h),
                      Container(
                        width: 1.sw,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(32.r),
                          color:AppColor.mainContainerBackGround
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 15.w,
                                vertical: 20.h,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Instant Analysis",
                                    style: AppTextStyle.font18bold,
                                  ),
                                  SizedBox(height: 4.h),
                                  Text(
                                    "Have an image? Upload it for an\ninstant security check.",
                                    style: AppTextStyle.font12semibold.copyWith(
                                      fontWeight: FontWeight.w400,
                                      color: AppColor.grayText,
                                      letterSpacing: 0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Spacer(),
                            AppBottom(
                              text: "Upload",
                              boxShadow: [],
                              color: AppColor.blue,
                              backGroundColor: Color.fromRGBO(27, 40, 61, 145),
                              textStyle: AppTextStyle.font14regular.copyWith(
                                color: AppColor.blue,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(width: 20.w),
                          ],
                        ),
                      ),
                      SizedBox(height: 16.h),
                      ActivitiesList(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
