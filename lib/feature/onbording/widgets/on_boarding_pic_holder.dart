// ignore_for_file: strict_top_level_inference, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syrian_currency/core/constants/app_color.dart';
import 'package:syrian_currency/core/constants/app_text_style.dart';

class OnboardingPicHolder extends StatelessWidget {
  final String imagePath;
  final BoxFit? fit;
  final bool isActive;
  final double? width;
  final double? hight;
  final Color? color1;
  final Color? color2;

  const OnboardingPicHolder({
    super.key,
    required this.imagePath,
    required this.isActive,
    this.fit,
    this.width,
    this.hight,
    this.color1,
    this.color2,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      width: width ?? 342.w,
      height: hight ?? 400.5.h,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(32),

        border: Border.all(color: Colors.white.withOpacity(0.08), width: 1),
      ),
      child: Stack(
        children: [
          Positioned(
            top: -60,
            right: -60,
            child: _glow(
              color1 ?? Colors.white.withOpacity(0.00),
              color2 ?? Colors.white.withOpacity(0.15),
            ),
          ),

          Positioned(
            bottom: -60,
            left: -60,
            child: _glow(
              color1 ?? Colors.white.withOpacity(0.00),
              color2 ?? Colors.white.withOpacity(0.15),
            ),
          ),

          Center(
            child: Container(
              width: 274.w,
              height: 360.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                image: DecorationImage(
                  image: AssetImage(imagePath),
                  fit: fit ?? BoxFit.cover,
                ),
              ),
            ),
          ),

          //bottom button
          Positioned(
            bottom: 60,
            left: 55,

            child: isActive
                ? SizedBox()
                : Container(
                    height: 34,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Color(0xFF14396B),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.08),
                        width: 1,
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.remove_red_eye_outlined,
                            size: 14,
                            color: AppColor.blue,
                          ),
                          SizedBox(width: 6),
                          Text(
                            "DEEP SCAN ACTIVE",
                            style: AppTextStyle.font12semibold,
                          ),
                        ],
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

/// 🔥 blur glow widget
Widget _glow(color1, color2) {
  return Container(
    width: 170,
    height: 170,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: color1,
      boxShadow: [BoxShadow(color: color2, blurRadius: 50, spreadRadius: 80)],
    ),
  );
}
