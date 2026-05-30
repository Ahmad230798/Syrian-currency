// ignore_for_file: deprecated_member_use

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syrian_currency/core/constants/app_color.dart';
import 'package:syrian_currency/core/constants/app_text_style.dart';
import 'package:syrian_currency/core/helper/snack_bar_helper.dart';

import '../models/admin_models.dart';
import '../logic/admin_cubit.dart';
import '../logic/admin_state.dart';
import '../widgets/admin_stat_card.dart';
import '../widgets/admin_user_card.dart';

class AdminUsersTab extends StatelessWidget {
  const AdminUsersTab({super.key});

  // 1. نافذة التحذير قبل الحذف (Safety First)
  void _showDeleteConfirmation(
    BuildContext context,
    AdminUserModel user,
    AdminCubit adminCubit,
  ) {
    showDialog(
      context: context,
      builder: (dialogContext) => Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24.0),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: Container(
              width: 400.0,
              padding: const EdgeInsets.all(32.0),
              decoration: BoxDecoration(
                color: const Color.fromRGBO(
                  20,
                  15,
                  15,
                  0.95,
                ), // لون مائل للاحمرار قليلاً
                border: Border.all(color: Colors.redAccent.withOpacity(0.5)),
                borderRadius: BorderRadius.circular(24.0),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.warning_amber_rounded,
                    color: Colors.redAccent,
                    size: 64.0,
                  ),
                  const SizedBox(height: 24.0),
                  Text(
                    "Delete User Account?",
                    style: AppTextStyle.font20extrabold.copyWith(
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    "Are you sure you want to permanently delete ${user.fullName}? This action cannot be undone and all their data will be erased.",
                    textAlign: TextAlign.center,
                    style: AppTextStyle.font14regular.copyWith(
                      color: AppColor.grayText,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 32.0),
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () => Navigator.pop(dialogContext),
                          child: Text(
                            "Cancel",
                            style: AppTextStyle.font16medium.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16.0),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.redAccent,
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                          ),
                          onPressed: () {
                            Navigator.pop(dialogContext); // إغلاق نافذة التأكيد
                            adminCubit.deleteUser(user.id); // تنفيذ الحذف!
                          },
                          child: Text(
                            "Delete",
                            style: AppTextStyle.font16medium.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // 2. نافذة الإدارة وتغيير الصلاحيات
  void _showRoleDialog(BuildContext context, AdminUserModel user) {
    String selectedRole = user.role;
    final adminCubit = context.read<AdminCubit>();

    showDialog(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (innerContext, setState) {
          return Dialog(
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
                        "Manage account for",
                        style: AppTextStyle.font14regular.copyWith(
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        user.fullName,
                        style: AppTextStyle.font20extrabold.copyWith(
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(height: 32.0),

                      _buildRoleOption(
                        "user",
                        AppColor.grayText,
                        selectedRole,
                        (val) => setState(() => selectedRole = val),
                      ),
                      const SizedBox(height: 16.0),
                      _buildRoleOption(
                        "expert",
                        Colors.purpleAccent,
                        selectedRole,
                        (val) => setState(() => selectedRole = val),
                      ),
                      const SizedBox(height: 16.0),
                      _buildRoleOption(
                        "admin",
                        AppColor.green,
                        selectedRole,
                        (val) => setState(() => selectedRole = val),
                      ),

                      const SizedBox(height: 40.0),

                      // زر حفظ الصلاحيات
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
                          onPressed: () {
                            Navigator.pop(dialogContext);
                            adminCubit.changeRole(user.id, selectedRole);
                          },
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
                      const SizedBox(height: 16.0),

                      // زر الحذف (باللون الأحمر)
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 20.0),
                            side: BorderSide(
                              color: Colors.redAccent.withOpacity(0.5),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                          ),
                          onPressed: () {
                            Navigator.pop(
                              dialogContext,
                            ); // نغلق نافذة الإدارة أولاً
                            _showDeleteConfirmation(
                              context,
                              user,
                              adminCubit,
                            ); // ثم نفتح رسالة التحذير!
                          },
                          child: Text(
                            "Delete Account",
                            style: AppTextStyle.font16medium.copyWith(
                              color: Colors.redAccent,
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
          );
        },
      ),
    );
  }

  Widget _buildRoleOption(
    String roleValue,
    Color color,
    String groupValue,
    ValueChanged<String> onChanged,
  ) {
    bool isSelected = roleValue == groupValue;
    return InkWell(
      onTap: () => onChanged(roleValue),
      borderRadius: BorderRadius.circular(12.0),
      child: Container(
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
              roleValue.toUpperCase(),
              style: AppTextStyle.font16medium.copyWith(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
            const Spacer(),
            if (isSelected) Icon(Icons.check_circle, color: color),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminCubit, AdminState>(
      listener: (context, state) {
        if (state is AdminChangeRoleSuccess) {
          SnackBarHelper.showSuccess(context, state.message);
        } else if (state is AdminDeleteUserSuccess) {
          SnackBarHelper.showSuccess(
            context,
            state.message,
          ); // رسالة نجاح الحذف
        } else if (state is AdminError) {
          SnackBarHelper.showError(context, state.message);
        }
      },
      buildWhen: (previous, current) =>
          current is AdminLoading || current is AdminSuccess,
      builder: (context, state) {
        if (state is AdminLoading) {
          return const Center(
            child: CircularProgressIndicator(color: AppColor.blue),
          );
        }

        if (state is AdminSuccess) {
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

                // الإحصائيات
                Row(
                  children: [
                    Expanded(
                      child: AdminStatCard(
                        title: "Total Scans",
                        value: "${state.stats.totalScans}",
                        icon: Icons.radar,
                        iconColor: AppColor.blue,
                        bgColor: AppColor.blue.withOpacity(0.1),
                        trend: "Global",
                      ),
                    ),
                    const SizedBox(width: 16.0),
                    Expanded(
                      child: AdminStatCard(
                        title: "Counterfeits",
                        value: "${state.stats.counterfeits}",
                        icon: Icons.warning_amber_rounded,
                        iconColor: AppColor.red,
                        bgColor: AppColor.red.withOpacity(0.1),
                        trend: "Detected",
                      ),
                    ),
                    const SizedBox(width: 16.0),
                    Expanded(
                      child: AdminStatCard(
                        title: "Total Users",
                        value: "${state.stats.totalUsers}",
                        icon: Icons.group,
                        iconColor: AppColor.green,
                        bgColor: AppColor.green.withOpacity(0.1),
                        trend: "Active",
                      ),
                    ),
                    const SizedBox(width: 16.0),
                    Expanded(
                      child: AdminStatCard(
                        title: "Active Experts",
                        value: "${state.stats.activeExperts}",
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
                        border: Border.all(
                          color: Colors.white.withOpacity(0.1),
                        ),
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

                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: state.users.length,
                  itemBuilder: (context, index) {
                    final user = state.users[index];
                    return AdminUserCard(
                      name: user.fullName,
                      email: user.email,
                      scans: user.scanCount,
                      role: user.role,
                      onManageTap: () => _showRoleDialog(context, user),
                    );
                  },
                ),
              ],
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
