import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:syrian_currency/core/constants/app_color.dart';
import 'package:syrian_currency/core/constants/app_text_style.dart';

import '../widgets/admin_stat_card.dart';
import '../widgets/admin_user_card.dart';

class AdminUsersTab extends StatelessWidget {
  const AdminUsersTab({super.key});

  void _showRoleDialog(BuildContext context, String currentName) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24.0),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: Container(
              width: 450.0,
              padding: const EdgeInsets.all(32.0),
              decoration: BoxDecoration(
                color: const Color.fromRGBO(15, 20, 30, 0.9),
                border: Border.all(color: Colors.white.withOpacity(0.1)),
                borderRadius: BorderRadius.circular(24.0),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Change role for",
                    style: AppTextStyle.font14regular.copyWith(fontSize: 14),
                  ),
                  Text(
                    currentName,
                    style: AppTextStyle.font20extrabold.copyWith(fontSize: 20),
                  ),
                  const SizedBox(height: 32.0),

                  _buildRoleOption("User", AppColor.grayText),
                  const SizedBox(height: 16.0),
                  _buildRoleOption(
                    "Expert",
                    Colors.purpleAccent,
                    isSelected: true,
                  ),
                  const SizedBox(height: 16.0),
                  _buildRoleOption("Admin", AppColor.green),

                  const SizedBox(height: 40.0),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.blue,
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        "Save Changes",
                        style: AppTextStyle.font16medium.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRoleOption(String role, Color color, {bool isSelected = false}) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: isSelected ? color.withOpacity(0.1) : Colors.transparent,
        border: Border.all(
          color: isSelected
              ? color.withOpacity(0.5)
              : Colors.white.withOpacity(0.1),
        ),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        children: [
          Icon(Icons.circle, color: color, size: 12.0),
          const SizedBox(width: 12.0),
          Text(
            role,
            style: AppTextStyle.font16medium.copyWith(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
          const Spacer(),
          if (isSelected) Icon(Icons.check_circle, color: color),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "System Users Directory",
            style: AppTextStyle.font24bold.copyWith(fontSize: 24),
          ),
          Text(
            "Manage network access, verify identities, and assign security roles.",
            style: AppTextStyle.font14regular.copyWith(fontSize: 14),
          ),
          const SizedBox(height: 32.0),

          Row(
            children: [
              Expanded(
                child: AdminStatCard(
                  title: "Total Scans",
                  value: "1.2M",
                  icon: Icons.radar,
                  iconColor: AppColor.blue,
                  bgColor: AppColor.blue.withOpacity(0.1),
                  trend: "↑ 12%",
                ),
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: AdminStatCard(
                  title: "Counterfeits",
                  value: "3,492",
                  icon: Icons.warning_amber_rounded,
                  iconColor: AppColor.red,
                  bgColor: AppColor.red.withOpacity(0.1),
                  trend: "↑ 3.2%",
                ),
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: AdminStatCard(
                  title: "Total Users",
                  value: "14,209",
                  icon: Icons.group,
                  iconColor: AppColor.green,
                  bgColor: AppColor.green.withOpacity(0.1),
                  trend: "↑ 5%",
                ),
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: AdminStatCard(
                  title: "Active Experts",
                  value: "428",
                  icon: Icons.verified_user,
                  iconColor: Colors.purpleAccent,
                  bgColor: Colors.purpleAccent.withOpacity(0.1),
                  trend: "Stable",
                ),
              ),
            ],
          ),
          const SizedBox(height: 40.0),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Active Personnel",
                style: AppTextStyle.font18bold.copyWith(fontSize: 18),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0,
                ),
                decoration: BoxDecoration(
                  color: AppColor.mainContainerBackGround,
                  border: Border.all(color: Colors.white.withOpacity(0.1)),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.filter_list,
                      color: Colors.white,
                      size: 18.0,
                    ),
                    const SizedBox(width: 8.0),
                    Text(
                      "Filter",
                      style: AppTextStyle.font14regular.copyWith(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16.0),

          AdminUserCard(
            name: "Sarah Jenkins",
            email: "s.jenkins@shield.ai",
            scans: 1420,
            role: "admin",
            onManageTap: () => _showRoleDialog(context, "Sarah Jenkins"),
          ),
          AdminUserCard(
            name: "Marcus Chen",
            email: "m.chen@contractor.net",
            scans: 84,
            role: "user",
            onManageTap: () => _showRoleDialog(context, "Marcus Chen"),
          ),
          AdminUserCard(
            name: "Elena Wright",
            email: "e.wright@shield.ai",
            scans: 4092,
            role: "expert",
            onManageTap: () => _showRoleDialog(context, "Elena Wright"),
          ),
        ],
      ),
    );
  }
}
