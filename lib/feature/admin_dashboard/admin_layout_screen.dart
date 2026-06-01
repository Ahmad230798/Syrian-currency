// ignore_for_file: deprecated_member_use

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:syrian_currency/core/constants/app_color.dart';
import 'package:syrian_currency/core/constants/app_text_style.dart';
import 'package:syrian_currency/feature/admin_dashboard/tabs/admin_dashboard_tab.dart';
import 'package:syrian_currency/feature/admin_dashboard/tabs/admin_settings_tab.dart';

import 'tabs/admin_users_tab.dart';
import 'tabs/admin_scan_history_tab.dart';
import 'tabs/admin_ai_feedback_tab.dart';
import 'tabs/admin_policies_tab.dart';

class AdminLayoutScreen extends StatefulWidget {
  const AdminLayoutScreen({super.key});

  @override
  State<AdminLayoutScreen> createState() => _AdminLayoutScreenState();
}

class _AdminLayoutScreenState extends State<AdminLayoutScreen> {
  int _selectedIndex = 0;

  final List<Widget> _tabs = [
    const AdminDashboardTab(),
    const AdminUsersTab(),
    const AdminScanHistoryTab(),
    const AdminAiFeedbackTab(),
    const AdminPoliciesTab(),
    const AdminSettingsTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backGroundColor,
      body: Row(
        children: [
          // 1. الشريط الجانبي (Sidebar) - تم استخدام قيم ثابتة للويب
          _buildSidebar(),

          // 2. مساحة العمل الرئيسية (Main Workspace)
          Expanded(
            child: Column(
              children: [
                // الشريط العلوي (Top Navbar)
                _buildTopBar(),

                // المحتوى المتغير (Dynamic Content)
                Expanded(
                  child: IndexedStack(index: _selectedIndex, children: _tabs),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSidebar() {
    return Container(
      width: 260.0, // عرض ثابت ممتاز للديسك توب بدلاً من .w
      decoration: BoxDecoration(
        color: const Color.fromRGBO(23, 30, 41, 0.4),
        border: Border(
          right: BorderSide(color: Colors.white.withOpacity(0.05)),
        ),
      ),
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.security,
                          color: AppColor.blue,
                          size: 32.0,
                        ),
                        const SizedBox(width: 8.0),
                        Text(
                          "Shield AI",
                          style: AppTextStyle.font24bold.copyWith(
                            color: AppColor.blue,
                            fontSize: 24,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      "Cyber-Security Hub",
                      style: AppTextStyle.font12semibold.copyWith(
                        color: AppColor.grayText,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  children: [
                    _buildNavItem("Dashboard", Icons.dashboard_outlined, 0),
                    _buildNavItem("User Management", Icons.group_outlined, 1),
                    _buildNavItem("Scan History", Icons.history_outlined, 2),
                    _buildNavItem("AI Feedback", Icons.psychology_outlined, 3),
                    _buildNavItem("Policies", Icons.policy_outlined, 4),
                    _buildNavItem("Settings", Icons.settings_outlined, 5),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.blue,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                  icon: const Icon(
                    Icons.rocket_launch,
                    color: Colors.white,
                    size: 20,
                  ),
                  label: Text(
                    "Deploy Patch",
                    style: AppTextStyle.font14regular.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(String title, IconData icon, int index) {
    bool isSelected = _selectedIndex == index;
    return InkWell(
      onTap: () => setState(() => _selectedIndex = index),
      borderRadius: BorderRadius.circular(12.0),
      child: Container(
        margin: const EdgeInsets.only(bottom: 8.0),
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColor.blue.withOpacity(0.15)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12.0),
          border: isSelected
              ? const Border(
                  right: BorderSide(color: AppColor.blue, width: 3.0),
                )
              : null,
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isSelected ? AppColor.blue : AppColor.grayText,
              size: 22.0,
            ),
            const SizedBox(width: 12.0),
            Text(
              title,
              style: AppTextStyle.font14regular.copyWith(
                color: isSelected ? AppColor.blue : AppColor.grayText,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return Container(
      height: 70.0, // ارتفاع ثابت
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      decoration: BoxDecoration(
        color: AppColor.backGroundColor.withOpacity(0.8),
        border: Border(
          bottom: BorderSide(color: Colors.white.withOpacity(0.05)),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Search - تم حل الـ Overflow بتحديد عرض ثابت وتوسيع مناسب
          Container(
            width: 300.0, // عرض ثابت مناسب للبحث بدلاً من 300.w
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            decoration: BoxDecoration(
              color: AppColor.mainContainerBackGround,
              borderRadius: BorderRadius.circular(24.0),
              border: Border.all(color: Colors.white.withOpacity(0.05)),
            ),
            child: Row(
              children: [
                const Icon(Icons.search, color: AppColor.grayText, size: 20.0),
                const SizedBox(width: 8.0),
                Expanded(
                  child: Text(
                    "Search...",
                    style: AppTextStyle.font14regular.copyWith(
                      color: AppColor.grayText,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Actions
          Row(
            children: [
              const SizedBox(width: 16.0),
              const Icon(
                Icons.shield_outlined,
                color: AppColor.grayText,
                size: 24.0,
              ),
              const SizedBox(width: 16.0),
              Container(
                width: 40.0,
                height: 40.0,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColor.blue,
                ),
                child: const Icon(Icons.person, color: Colors.white, size: 20),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
