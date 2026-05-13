// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syrian_currency/core/constants/app_color.dart';

class CameraControlsPanel extends StatelessWidget {
  final bool isFlashOn;
  final VoidCallback onFlashToggle;
  final VoidCallback onGalleryTap;
  final VoidCallback onCaptureTap;

  const CameraControlsPanel({
    super.key,
    required this.isFlashOn,
    required this.onFlashToggle,
    required this.onGalleryTap,
    required this.onCaptureTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 24.h),
      decoration: BoxDecoration(
        color: AppColor.blureColor.withOpacity(0.6),
        borderRadius: BorderRadius.circular(32.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildSecondaryButton(icon: Icons.photo_library, onTap: onGalleryTap),

          GestureDetector(
            onTap: onCaptureTap,
            child: Container(
              width: 72.w,
              height: 72.w,
              padding: EdgeInsets.all(4.w),
              decoration: BoxDecoration(
                color: AppColor.blue.withOpacity(0.2),
                shape: BoxShape.circle,
                border: Border.all(color: AppColor.blue, width: 3.w),
              ),
              child: Container(
                decoration: const BoxDecoration(
                  color: AppColor.blue,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.photo_camera,
                  color: Colors.white,
                  size: 30.sp,
                ),
              ),
            ),
          ),

          _buildSecondaryButton(
            icon: isFlashOn ? Icons.flash_on : Icons.flash_off,
            onTap: onFlashToggle,
            iconColor: isFlashOn ? AppColor.blue : Colors.white,
          ),
        ],
      ),
    );
  }

  Widget _buildSecondaryButton({
    required IconData icon,
    required VoidCallback onTap,
    Color iconColor = Colors.white,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 48.w,
        height: 48.w,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.05),
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white.withOpacity(0.1)),
        ),
        child: Icon(icon, color: iconColor, size: 22.sp),
      ),
    );
  }
}
