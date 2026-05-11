import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syrian_currency/core/constants/app_color.dart';
import 'package:syrian_currency/feature/scan_result/ui/scan_result_screen.dart';
import 'package:syrian_currency/feature/scan_result/widgets/menu_item.dart';

class ValidationPoints extends StatelessWidget {
  const ValidationPoints({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(48.r),
        color: AppColor.mainContainerBackGround,
      ),

      child: Column(
        
        children: [
          MenuItem(
            icon: Icons.water_drop_outlined,
            text: "Watermark Verification",
            suffixIcon: Icons.check_circle_outline,
          ),
          Divider(thickness: 0.5, color: Colors.white.withOpacity(0.8)),
          MenuItem(
            icon: Icons.texture,
            text: "3D Security Ribbon",
            suffixIcon: Icons.check_circle_outline,
          ),
          Divider(thickness: 0.5, color: Colors.white.withOpacity(0.8)),
          MenuItem(
            icon: Icons.flare,
            text: "Microprinting Analysis",
            suffixIcon: Icons.check_circle_outline,
          ),
        ],
      ),
    );
  }
}
