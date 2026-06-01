// ignore_for_file: deprecated_member_use

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:syrian_currency/core/constants/app_color.dart';
import 'package:syrian_currency/core/constants/app_text_style.dart';
import 'package:syrian_currency/core/helper/navigation.dart';
import 'package:syrian_currency/core/networking/servicse.dart';
import 'package:syrian_currency/core/routing/routes.dart';

class AdminSettingsTab extends StatefulWidget {
  const AdminSettingsTab({super.key});

  @override
  State<AdminSettingsTab> createState() => _AdminSettingsTabState();
}

class _AdminSettingsTabState extends State<AdminSettingsTab> {
  // متغيرات لحالة أزرار الإعدادات الوهمية (لإعطاء طابع احترافي للداشبورد)
  bool _emailAlerts = true;
  bool _autoBackup = true;
  bool _maintenanceMode = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Platform Settings",
            style: AppTextStyle.font24bold.copyWith(fontSize: 24),
          ),
          const SizedBox(height: 8.0),
          Text(
            "Manage your administrator account and global system configurations.",
            style: AppTextStyle.font14regular.copyWith(
              fontSize: 14,
              color: AppColor.grayText,
            ),
          ),
          const SizedBox(height: 32.0),

          // 1. بطاقة الحساب الشخصي (Profile Card)
          _buildSectionHeader("ADMINISTRATOR IDENTITY"),
          const SizedBox(height: 12.0),
          Container(
            padding: const EdgeInsets.all(24.0),
            decoration: BoxDecoration(
              color: AppColor.mainContainerBackGround,
              borderRadius: BorderRadius.circular(16.0),
              border: Border.all(color: Colors.white.withOpacity(0.05)),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 36.0,
                  backgroundColor: AppColor.blue.withOpacity(0.2),
                  child: const Icon(
                    Icons.admin_panel_settings,
                    color: AppColor.blue,
                    size: 36.0,
                  ),
                ),
                const SizedBox(width: 20.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "System Administrator",
                        style: AppTextStyle.font18bold.copyWith(fontSize: 20),
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        "Full Access • Admin Role",
                        style: AppTextStyle.font14regular.copyWith(
                          color: AppColor.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.edit, size: 18),
                  label: const Text("Edit Profile"),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white,
                    side: BorderSide(color: Colors.white.withOpacity(0.2)),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 16.0,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32.0),

          // 2. بطاقة إعدادات النظام (System Configuration)
          _buildSectionHeader("SYSTEM CONFIGURATION"),
          const SizedBox(height: 12.0),
          Container(
            padding: const EdgeInsets.all(24.0),
            decoration: BoxDecoration(
              color: AppColor.mainContainerBackGround,
              borderRadius: BorderRadius.circular(16.0),
              border: Border.all(color: Colors.white.withOpacity(0.05)),
            ),
            child: Column(
              children: [
                _buildSettingSwitch(
                  title: "Email Alerts for Anomalies",
                  subtitle:
                      "Receive instant emails when a counterfeit is detected.",
                  icon: Icons.mark_email_unread_outlined,
                  value: _emailAlerts,
                  onChanged: (val) => setState(() => _emailAlerts = val),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: Divider(color: Colors.white10, thickness: 1),
                ),
                _buildSettingSwitch(
                  title: "Automated Database Backup",
                  subtitle: "Daily backups of scan history and user directory.",
                  icon: Icons.cloud_sync_outlined,
                  value: _autoBackup,
                  onChanged: (val) => setState(() => _autoBackup = val),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: Divider(color: Colors.white10, thickness: 1),
                ),
                _buildSettingSwitch(
                  title: "Maintenance Mode",
                  subtitle:
                      "Suspend user access temporarily for system upgrades.",
                  icon: Icons.construction,
                  iconColor: Colors.amber,
                  value: _maintenanceMode,
                  onChanged: (val) => setState(() => _maintenanceMode = val),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32.0),

          // 3. منطقة الخطر (Danger Zone - Logout)
          _buildSectionHeader("DANGER ZONE"),
          const SizedBox(height: 12.0),
          Container(
            padding: const EdgeInsets.all(24.0),
            decoration: BoxDecoration(
              color: Colors.redAccent.withOpacity(0.05),
              borderRadius: BorderRadius.circular(16.0),
              border: Border.all(color: Colors.redAccent.withOpacity(0.3)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Secure Logout",
                      style: AppTextStyle.font18bold.copyWith(
                        color: Colors.redAccent,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      "End your current administrative session.",
                      style: AppTextStyle.font14regular.copyWith(
                        color: AppColor.grayText,
                      ),
                    ),
                  ],
                ),
                ElevatedButton.icon(
                  onPressed: () async {
                    // 🌟 كود تسجيل الخروج الحقيقي
                    final pref = SharedPreferencesService();
                    await pref.clearTokens();
                    if (context.mounted) {
                      context.pushNamedAndRemoveUntil(Routes.logIn);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24.0,
                      vertical: 18.0,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  icon: const Icon(Icons.logout, size: 20),
                  label: Text(
                    "Log Out",
                    style: AppTextStyle.font14regular.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 50.0),
        ],
      ),
    );
  }

  // ويدجت مساعدة لعناوين الأقسام
  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: AppTextStyle.font10bold.copyWith(
        color: AppColor.grayText,
        letterSpacing: 1.5,
        fontSize: 12,
      ),
    );
  }

  // ويدجت مساعدة لمفاتيح الإعدادات
  Widget _buildSettingSwitch({
    required String title,
    required String subtitle,
    required IconData icon,
    required bool value,
    required ValueChanged<bool> onChanged,
    Color iconColor = AppColor.grayText,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Icon(icon, color: iconColor, size: 24),
        ),
        const SizedBox(width: 16.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTextStyle.font16medium.copyWith(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 4.0),
              Text(
                subtitle,
                style: AppTextStyle.font12semibold.copyWith(
                  color: AppColor.grayText,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
        Switch(
          value: value,
          onChanged: onChanged,
          activeColor: AppColor.blue,
          inactiveTrackColor: AppColor.backGroundColor,
        ),
      ],
    );
  }
}
