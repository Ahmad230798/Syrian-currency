// ignore_for_file: deprecated_member_use

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syrian_currency/core/constants/app_color.dart';
import 'package:syrian_currency/core/constants/app_text_style.dart';

class ImageResult extends StatelessWidget {
  const ImageResult({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.mainContainerBackGround,
        borderRadius: BorderRadius.circular(18.r),
      ),
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                width: 1.sw,
                height: 170.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(18.r),
                    topRight: Radius.circular(18.r),
                  ),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("assets/images/result_image.png"),
                  ),
                ),
              ),
              Positioned(
                child: Container(
                  width: 1.sw,
                  height: 85.h,

                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xff3C83F6).withOpacity(0),
                        Color(0xff3C83F6).withOpacity(0.2),
                        Color(0xff3C83F6).withOpacity(0),
                      ],
                      stops: [0, 0.5, 1],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 12,
                right: 12,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(999.r),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 25.h,

                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(999.r),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 4.h,
                            horizontal: 12.w,
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.circle,
                                color: AppColor.blue,
                                size: 10,
                              ),
                              6.horizontalSpace,
                              Text(
                                "SYP AI SHIELD",
                                style: AppTextStyle.font10bold,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 22.h),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("USD 100 Bill", style: AppTextStyle.font20extrabold),
                    Text(
                      "Series 2017 • Benjamin\nFranklin",
                      style: AppTextStyle.font14regular,
                    ),
                  ],
                ),
                Spacer(),
                Column(
                  children: [
                    Text(
                      "Serial Number",
                      style: AppTextStyle.font12semibold.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColor.grayText,
                      ),
                    ),
                    Text(
                      "LF 18402947B",
                      style: AppTextStyle.font14regular.copyWith(
                        color: AppColor.blue,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
