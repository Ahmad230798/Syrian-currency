import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syrian_currency/core/constants/app_color.dart';

class ProfileImageHolder extends StatelessWidget {
  final String imagePath;
  final IconData icon;
  const ProfileImageHolder({super.key, required this.imagePath, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 128.w,
          height: 128.h,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              strokeAlign: BorderSide.strokeAlignInside,
              color: AppColor.blue.withOpacity(0.2),
              width: 4.w,
              style: BorderStyle.solid,
            ),
            image: DecorationImage(
              image: AssetImage(imagePath),
            ),
          ),
        ),
        Positioned(
          bottom: 1,
          right: 2,
          child: CircleAvatar(
            backgroundColor: AppColor.blue,
            child: Icon(icon, color: Colors.white),
          ),
        ),
      ],
    );
  }
}
