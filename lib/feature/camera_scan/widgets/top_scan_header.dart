// ignore_for_file: deprecated_member_use

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syrian_currency/core/constants/app_text_style.dart';

class TopScanHeader extends StatelessWidget {
  final VoidCallback onInfoTap;

  const TopScanHeader({super.key, required this.onInfoTap});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildGlassButton(
              icon: Icons.arrow_back,
              onTap: () => Navigator.pop(context),
            ),
            _buildGlassContainer(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
              child: Text(
                "SYP SHIELD AI",
                style: AppTextStyle.font10bold.copyWith(
                  letterSpacing: 1,
                  color: Colors.white,
                ),
              ),
            ),
            _buildGlassButton(icon: Icons.info_outline, onTap: onInfoTap),
          ],
        ),
      ),
    );
  }

  Widget _buildGlassButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(50.r),
      child: _buildGlassContainer(
        padding: EdgeInsets.all(10.w),
        child: Icon(icon, color: Colors.white, size: 24.sp),
      ),
    );
  }

  Widget _buildGlassContainer({
    required Widget child,
    required EdgeInsetsGeometry padding,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(100.r),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            border: Border.all(color: Colors.white.withOpacity(0.1)),
            borderRadius: BorderRadius.circular(100.r),
          ),
          child: child,
        ),
      ),
    );
  }
}
