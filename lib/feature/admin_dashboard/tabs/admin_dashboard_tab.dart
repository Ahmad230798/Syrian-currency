// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syrian_currency/core/constants/app_color.dart';
import 'package:syrian_currency/core/constants/app_text_style.dart';
import '../logic/admin_cubit.dart';
import '../logic/admin_state.dart';
import '../widgets/admin_stat_card.dart';

class AdminDashboardTab extends StatelessWidget {
  const AdminDashboardTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdminCubit, AdminState>(
      buildWhen: (previous, current) =>
          current is AdminLoading || current is AdminSuccess,
      builder: (context, state) {
        if (state is AdminLoading) {
          return const Center(
            child: CircularProgressIndicator(color: AppColor.blue),
          );
        }

        if (state is AdminSuccess) {
          int pendingReports = state.feedbacks
              .where((f) => f.status == 'pending')
              .length;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "System Overview",
                  style: AppTextStyle.font24bold.copyWith(fontSize: 24),
                ),
                const SizedBox(height: 8.0),
                Text(
                  "High-level summary of the network security and activity.",
                  style: AppTextStyle.font14regular.copyWith(
                    fontSize: 14,
                    color: AppColor.grayText,
                  ),
                ),
                const SizedBox(height: 32.0),

                // 🌟 كروت الإحصائيات السريعة للداشبورد
                Row(
                  children: [
                    Expanded(
                      child: AdminStatCard(
                        title: "Total Network Scans",
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
                        title: "Detected Counterfeits",
                        value: "${state.stats.counterfeits}",
                        icon: Icons.warning_amber_rounded,
                        iconColor: AppColor.red,
                        bgColor: AppColor.red.withOpacity(0.1),
                        trend: "Threats",
                      ),
                    ),
                    const SizedBox(width: 16.0),
                    Expanded(
                      child: AdminStatCard(
                        title: "Pending Reports",
                        value: "$pendingReports",
                        icon: Icons.report_problem_outlined,
                        iconColor: Colors.amber,
                        bgColor: Colors.amber.withOpacity(0.1),
                        trend: "Action Needed",
                      ),
                    ),
                    const SizedBox(width: 16.0),
                    Expanded(
                      child: AdminStatCard(
                        title: "Active Users",
                        value: "${state.stats.totalUsers}",
                        icon: Icons.group,
                        iconColor: AppColor.green,
                        bgColor: AppColor.green.withOpacity(0.1),
                        trend: "Live",
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32.0),

                // 🌟 قسم الترحيب السريع أو التوجيه
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(32.0),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColor.blue.withOpacity(0.3),
                        AppColor.mainContainerBackGround,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16.0),
                    border: Border.all(color: AppColor.blue.withOpacity(0.3)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.shield,
                            color: AppColor.blue,
                            size: 40,
                          ),
                          const SizedBox(width: 16.0),
                          Text(
                            "All Systems Operational",
                            style: AppTextStyle.font20extrabold.copyWith(
                              color: Colors.white,
                              fontSize: 22,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16.0),
                      Text(
                        "DeepCAE models are actively monitoring the network. Navigate through the sidebar to manage users, review audit logs, and update security policies.",
                        style: AppTextStyle.font14regular.copyWith(
                          color: Colors.white70,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
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
