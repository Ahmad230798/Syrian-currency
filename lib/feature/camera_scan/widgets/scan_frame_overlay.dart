// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syrian_currency/core/constants/app_color.dart';

class ScanFrameOverlay extends StatelessWidget {
  final Animation<double> animation;

  const ScanFrameOverlay({super.key, required this.animation});

  @override
  Widget build(BuildContext context) {
    double frameWidth = 1.sw * 0.85;
    double frameHeight = frameWidth / 1.6;

    return SizedBox(
      width: frameWidth,
      height: frameHeight,
      child: Stack(
        children: [
          _buildCorner(top: true, left: true),
          _buildCorner(top: true, left: false),
          _buildCorner(top: false, left: true),
          _buildCorner(top: false, left: false),

          AnimatedBuilder(
            animation: animation,
            builder: (context, child) {
              return Positioned(
                top: animation.value * (frameHeight - 4.h),
                left: 0,
                right: 0,
                child: Container(
                  height: 2.h,
                  decoration: BoxDecoration(
                    color: AppColor.blue,
                    boxShadow: [
                      BoxShadow(
                        color: AppColor.blue.withOpacity(0.8),
                        blurRadius: 15,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCorner({required bool top, required bool left}) {
    double cornerSize = 24.w;
    double borderWidth = 4.w;
    Radius borderRadius = Radius.circular(16.r);

    return Positioned(
      top: top ? 0 : null,
      bottom: !top ? 0 : null,
      left: left ? 0 : null,
      right: !left ? 0 : null,
      child: Container(
        width: cornerSize,
        height: cornerSize,
        decoration: BoxDecoration(
          border: Border(
            top: top
                ? BorderSide(color: AppColor.blue, width: borderWidth)
                : BorderSide.none,
            bottom: !top
                ? BorderSide(color: AppColor.blue, width: borderWidth)
                : BorderSide.none,
            left: left
                ? BorderSide(color: AppColor.blue, width: borderWidth)
                : BorderSide.none,
            right: !left
                ? BorderSide(color: AppColor.blue, width: borderWidth)
                : BorderSide.none,
          ),
          borderRadius: BorderRadius.only(
            topLeft: top && left ? borderRadius : Radius.zero,
            topRight: top && !left ? borderRadius : Radius.zero,
            bottomLeft: !top && left ? borderRadius : Radius.zero,
            bottomRight: !top && !left ? borderRadius : Radius.zero,
          ),
        ),
      ),
    );
  }
}
