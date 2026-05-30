// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:syrian_currency/core/constants/app_color.dart';
import 'package:syrian_currency/core/constants/app_text_style.dart';

class AdminUserCard extends StatelessWidget {
  final String name;
  final String email;
  final int scans;
  final String role;
  final VoidCallback onManageTap;

  const AdminUserCard({
    super.key,
    required this.name,
    required this.email,
    required this.scans,
    required this.role,
    required this.onManageTap,
  });

  Color _getRoleColor() {
    if (role.toLowerCase() == 'admin') return AppColor.green;
    if (role.toLowerCase() == 'expert') return Colors.purpleAccent;
    return AppColor.grayText;
  }

  @override
  Widget build(BuildContext context) {
    Color roleColor = _getRoleColor();

    return Container(
      margin: const EdgeInsets.only(bottom: 12.0),
      decoration: BoxDecoration(
        color: AppColor.mainContainerBackGround.withOpacity(0.4),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 24.0,
              backgroundColor: roleColor.withOpacity(0.2),
              child: Text(
                name.substring(0, 2).toUpperCase(),
                style: AppTextStyle.font16medium.copyWith(
                  color: roleColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: AppTextStyle.font16medium.copyWith(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    email,
                    style: AppTextStyle.font12semibold.copyWith(
                      color: AppColor.grayText,
                      fontWeight: FontWeight.normal,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Row(
                    children: [
                      Text(
                        "$scans Scans",
                        style: AppTextStyle.font12semibold.copyWith(
                          color: AppColor.lightgray,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(width: 12.0),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8.0,
                          vertical: 2.0,
                        ),
                        decoration: BoxDecoration(
                          color: roleColor.withOpacity(0.1),
                          border: Border.all(color: roleColor.withOpacity(0.3)),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Text(
                          role.toUpperCase(),
                          style: AppTextStyle.font10bold.copyWith(
                            color: roleColor,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: onManageTap,
              borderRadius: BorderRadius.circular(8.0),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12.0,
                  vertical: 8.0,
                ),
                decoration: BoxDecoration(
                  color: AppColor.blue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Row(
                  children: [
                    Text(
                      "Manage",
                      style: AppTextStyle.font12semibold.copyWith(fontSize: 12),
                    ),
                    const SizedBox(width: 4.0),
                    const Icon(
                      Icons.keyboard_arrow_down,
                      color: AppColor.blue,
                      size: 16.0,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
