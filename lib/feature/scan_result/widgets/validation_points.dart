// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syrian_currency/core/constants/app_color.dart';
import 'package:syrian_currency/feature/camera_scan/model/scanner_response_model.dart';
import 'package:syrian_currency/feature/scan_result/widgets/menu_item.dart';

class ValidationPoints extends StatelessWidget {
  final ScanDataModel scanData;

  const ValidationPoints({super.key, required this.scanData});

  @override
  Widget build(BuildContext context) {
    IconData resultIcon = scanData.isGenuine
        ? Icons.check_circle_outline
        : Icons.cancel_outlined;
    Color resultColor = scanData.isGenuine ? AppColor.green : Colors.redAccent;

    return Container(
      width: 1.sw,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(48.r),
        color: AppColor.mainContainerBackGround,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(48.r),
        child: Column(
          children: [
            MenuItem(
              icon: Icons.auto_awesome,
              text: "DeepCAE Pattern Match",
              suffixIcon: resultIcon,
              suffixIconColor: resultColor,
            ),
            Divider(thickness: 0.5, color: Colors.white.withOpacity(0.8)),
            MenuItem(
              icon: Icons.texture,
              text: "Threshold Verification",
              suffixIcon: resultIcon,
              suffixIconColor: resultColor,
            ),
            Divider(thickness: 0.5, color: Colors.white.withOpacity(0.8)),
            MenuItem(
              icon: Icons.flare,
              text: "Structural Integrity",
              suffixIcon: resultIcon,
              suffixIconColor: resultColor,
            ),
          ],
        ),
      ),
    );
  }
}
