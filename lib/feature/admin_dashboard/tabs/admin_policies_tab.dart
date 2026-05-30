// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:syrian_currency/core/constants/app_color.dart';
import 'package:syrian_currency/core/constants/app_text_style.dart';

class AdminPoliciesTab extends StatelessWidget {
  const AdminPoliciesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Role & App Policies",
            style: AppTextStyle.font24bold.copyWith(fontSize: 24),
          ),
          Text(
            "Manage access controls, feature toggles, and rules.",
            style: AppTextStyle.font14regular.copyWith(fontSize: 14),
          ),
          const SizedBox(height: 32.0),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildRolePolicyCard(
                "Administrator",
                "Full System Access",
                Icons.admin_panel_settings,
                AppColor.green,
                "Unlimited",
                "365",
                true,
                true,
                true,
                true,
              ),
              const SizedBox(width: 16.0),
              _buildRolePolicyCard(
                "Domain Expert",
                "Review & Analysis",
                Icons.science,
                Colors.purpleAccent,
                "1000",
                "90",
                true,
                true,
                true,
                true,
              ),
              const SizedBox(width: 16.0),
              _buildRolePolicyCard(
                "Standard User",
                "Basic Scanning",
                Icons.person,
                AppColor.grayText,
                "10",
                "30",
                false,
                false,
                false,
                false,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRolePolicyCard(
    String title,
    String subtitle,
    IconData icon,
    Color color,
    String limit,
    String days,
    bool heatmap,
    bool mse,
    bool export,
    bool feedback,
  ) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(24.0),
        decoration: BoxDecoration(
          color: AppColor.mainContainerBackGround,
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(color: Colors.white.withOpacity(0.05)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Icon(icon, color: color),
                ),
                const SizedBox(width: 12.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: AppTextStyle.font18bold.copyWith(fontSize: 18),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        subtitle,
                        style: AppTextStyle.font12semibold.copyWith(
                          color: AppColor.grayText,
                          fontSize: 12,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24.0),
            _buildPolicyRow("Daily Scan Limit", limit),
            _buildPolicyRow("History Days", days),
            const SizedBox(height: 16.0),
            Text(
              "CAPABILITIES",
              style: AppTextStyle.font10bold.copyWith(
                color: AppColor.grayText,
                fontSize: 10,
              ),
            ),
            const SizedBox(height: 12.0),
            _buildToggleRow("View Heatmap", Icons.visibility, heatmap),
            _buildToggleRow("View MSE", Icons.analytics, mse),
            _buildToggleRow("Export Report", Icons.download, export),
            _buildToggleRow("Give Feedback", Icons.rate_review, feedback),
          ],
        ),
      ),
    );
  }

  Widget _buildPolicyRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: AppTextStyle.font14regular.copyWith(fontSize: 14)),
          Text(
            value,
            style: AppTextStyle.font14regular.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildToggleRow(String label, IconData icon, bool isActive) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                icon,
                size: 16.0,
                color: isActive ? AppColor.blue : AppColor.grayText,
              ),
              const SizedBox(width: 8.0),
              Text(
                label,
                style: AppTextStyle.font14regular.copyWith(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          Switch(
            value: isActive,
            onChanged: (val) {},
            activeColor: AppColor.blue,
            inactiveTrackColor: AppColor.backGroundColor,
          ),
        ],
      ),
    );
  }
}
