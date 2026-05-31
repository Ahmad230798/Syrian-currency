// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syrian_currency/core/constants/app_color.dart';
import 'package:syrian_currency/core/constants/app_text_style.dart';
import 'package:syrian_currency/core/helper/snack_bar_helper.dart';
import 'package:syrian_currency/feature/admin_dashboard/models/admin_models.dart';
import '../logic/admin_cubit.dart';
import '../logic/admin_state.dart';

class AdminPoliciesTab extends StatelessWidget {
  const AdminPoliciesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminCubit, AdminState>(
      listener: (context, state) {
        if (state is AdminPolicyUpdateSuccess) {
          SnackBarHelper.showSuccess(context, state.message);
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
                  "Role & App Policies",
                  style: AppTextStyle.font24bold.copyWith(fontSize: 24),
                ),
                Text(
                  "Manage access controls, feature toggles, and rules.",
                  style: AppTextStyle.font14regular.copyWith(fontSize: 14),
                ),
                const SizedBox(height: 32.0),

                // بناء الكروت ديناميكياً لكل دور قادم من الباك إند
                // بناء الكروت ديناميكياً لكل دور قادم من الباك إند
                state.policies.isEmpty
                    ? Center(
                        child: Padding(
                          padding: const EdgeInsets.all(40.0),
                          child: Text(
                            "No policies found. Please add them from Django Admin Panel.",
                            style: AppTextStyle.font16medium.copyWith(
                              color: AppColor.grayText,
                            ),
                          ),
                        ),
                      )
                    : Wrap(
                        spacing: 16.0,
                        runSpacing: 16.0,
                        children: state.policies.map((policy) {
                          return SizedBox(
                            width: 350.0,
                            child: _buildRolePolicyCard(context, policy),
                          );
                        }).toList(),
                      ),
              ],
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildRolePolicyCard(BuildContext context, AdminPolicyModel policy) {
    // تلوين وأيقونة بناءً على الدور
    Color color = AppColor.grayText;
    IconData icon = Icons.person;
    if (policy.role == 'admin') {
      color = AppColor.green;
      icon = Icons.admin_panel_settings;
    } else if (policy.role == 'expert') {
      color = Colors.purpleAccent;
      icon = Icons.science;
    }

    return Container(
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
                      policy.role.toUpperCase(),
                      style: AppTextStyle.font18bold.copyWith(fontSize: 18),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      "Role configuration",
                      style: AppTextStyle.font12semibold.copyWith(
                        color: AppColor.grayText,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24.0),
          _buildPolicyRow(
            "Daily Scan Limit",
            policy.dailyScanLimit < 0
                ? "Unlimited"
                : "${policy.dailyScanLimit}",
          ),
          _buildPolicyRow(
            "History Days",
            policy.historyDays < 0 ? "All Time" : "${policy.historyDays}",
          ),
          const SizedBox(height: 16.0),
          Text(
            "CAPABILITIES",
            style: AppTextStyle.font10bold.copyWith(
              color: AppColor.grayText,
              fontSize: 10,
            ),
          ),
          const SizedBox(height: 12.0),
          _buildToggleRow(
            context,
            policy.role,
            "can_view_heatmap",
            "View Heatmap",
            Icons.visibility,
            policy.canViewHeatmap,
          ),
          _buildToggleRow(
            context,
            policy.role,
            "can_view_mse",
            "View MSE",
            Icons.analytics,
            policy.canViewMse,
          ),
          _buildToggleRow(
            context,
            policy.role,
            "can_export_report",
            "Export Report",
            Icons.download,
            policy.canExportReport,
          ),
          _buildToggleRow(
            context,
            policy.role,
            "can_give_feedback",
            "Give Feedback",
            Icons.rate_review,
            policy.canGiveFeedback,
          ),
        ],
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

  Widget _buildToggleRow(
    BuildContext context,
    String role,
    String apiKey,
    String label,
    IconData icon,
    bool isActive,
  ) {
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
            onChanged: (val) {
              // عند ضغط الإدمن على الزر، سيتم إرسال الطلب فوراً للباك إند!
              context.read<AdminCubit>().togglePolicy(role, apiKey, val);
            },
            activeColor: AppColor.blue,
            inactiveTrackColor: AppColor.backGroundColor,
          ),
        ],
      ),
    );
  }
}
