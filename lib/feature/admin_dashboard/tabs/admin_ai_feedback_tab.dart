// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syrian_currency/core/constants/app_color.dart';
import 'package:syrian_currency/core/constants/app_text_style.dart';
import '../logic/admin_cubit.dart';
import '../logic/admin_state.dart';

class AdminAiFeedbackTab extends StatelessWidget {
  const AdminAiFeedbackTab({super.key});

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
          // حساب الإحصائيات من المصفوفة
          int pendingCount = state.feedbacks
              .where((f) => f.status == 'pending')
              .length;
          int reviewedCount = state.feedbacks
              .where((f) => f.status == 'reviewed')
              .length;
          int resolvedCount = state.feedbacks
              .where((f) => f.status == 'resolved')
              .length; // إذا كان هناك حالة rejected/resolved

          return SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Expert Feedback & Anomaly Reports",
                          style: AppTextStyle.font24bold.copyWith(fontSize: 24),
                        ),
                        Text(
                          "Review and resolve expert escalations and system anomalies.",
                          style: AppTextStyle.font14regular.copyWith(
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.mainContainerBackGround,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        side: BorderSide(color: Colors.white.withOpacity(0.1)),
                      ),
                      icon: const Icon(Icons.download, color: AppColor.blue),
                      label: Text(
                        "Export CSV",
                        style: AppTextStyle.font14regular.copyWith(
                          color: AppColor.blue,
                          fontSize: 14,
                        ),
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
                const SizedBox(height: 24.0),
                Row(
                  children: [
                    _buildStatCard(
                      "Pending",
                      "$pendingCount",
                      Icons.pending_actions,
                      Colors.amber,
                    ),
                    const SizedBox(width: 16.0),
                    _buildStatCard(
                      "Reviewed",
                      "$reviewedCount",
                      Icons.rate_review,
                      AppColor.blue,
                    ),
                    const SizedBox(width: 16.0),
                    _buildStatCard(
                      "Resolved/Rejected",
                      "$resolvedCount",
                      Icons.task_alt,
                      AppColor.green,
                    ),
                  ],
                ),
                const SizedBox(height: 32.0),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColor.mainContainerBackGround,
                    borderRadius: BorderRadius.circular(16.0),
                    border: Border.all(color: Colors.white.withOpacity(0.05)),
                  ),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: state.feedbacks.isEmpty
                        ? Padding(
                            padding: const EdgeInsets.all(32.0),
                            child: Text(
                              "No feedback reports submitted yet.",
                              style: AppTextStyle.font14regular.copyWith(
                                color: AppColor.grayText,
                              ),
                            ),
                          )
                        : DataTable(
                            headingRowColor: MaterialStateProperty.all(
                              Colors.white.withOpacity(0.02),
                            ),
                            dataRowHeight: 70.0,
                            columns: [
                              DataColumn(
                                label: Text(
                                  "REPORT ID & DATE",
                                  style: AppTextStyle.font10bold.copyWith(
                                    color: AppColor.grayText,
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  "EXPERT NAME",
                                  style: AppTextStyle.font10bold.copyWith(
                                    color: AppColor.grayText,
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  "SCAN VERDICT",
                                  style: AppTextStyle.font10bold.copyWith(
                                    color: AppColor.grayText,
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  "STATUS",
                                  style: AppTextStyle.font10bold.copyWith(
                                    color: AppColor.grayText,
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  "ACTION",
                                  style: AppTextStyle.font10bold.copyWith(
                                    color: AppColor.grayText,
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                            ],
                            // إنشاء الصفوف برمجياً
                            rows: state.feedbacks.map((f) {
                              Color verdictColor =
                                  f.scanResult.toLowerCase() == 'genuine'
                                  ? AppColor.green
                                  : Colors.redAccent;
                              Color statusColor = f.status == 'pending'
                                  ? Colors.amber
                                  : (f.status == 'reviewed'
                                        ? AppColor.blue
                                        : AppColor.green);

                              return _buildFeedbackRow(
                                "#F-${f.id}",
                                f.createdAt.substring(0, 10), // أخذ التاريخ فقط
                                f.expertName,
                                f.scanResult,
                                f.status,
                                verdictColor,
                                statusColor,
                              );
                            }).toList(),
                          ),
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

  Widget _buildStatCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: AppColor.mainContainerBackGround,
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(color: Colors.white.withOpacity(0.05)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Icon(icon, color: color),
            ),
            const SizedBox(height: 16.0),
            Text(
              title,
              style: AppTextStyle.font14regular.copyWith(fontSize: 14),
            ),
            Text(value, style: AppTextStyle.font24bold.copyWith(fontSize: 24)),
          ],
        ),
      ),
    );
  }

  DataRow _buildFeedbackRow(
    String id,
    String date,
    String name,
    String verdict,
    String status,
    Color verdictColor,
    Color statusColor,
  ) {
    return DataRow(
      cells: [
        DataCell(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                id,
                style: AppTextStyle.font14regular.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              Text(
                date,
                style: AppTextStyle.font12semibold.copyWith(
                  color: AppColor.grayText,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
        DataCell(
          Text(
            name,
            style: AppTextStyle.font14regular.copyWith(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
        ),
        DataCell(
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            decoration: BoxDecoration(
              color: verdictColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Text(
              verdict.toUpperCase(),
              style: AppTextStyle.font10bold.copyWith(
                color: verdictColor,
                fontSize: 10,
              ),
            ),
          ),
        ),
        DataCell(
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Text(
              status.toUpperCase(),
              style: AppTextStyle.font10bold.copyWith(
                color: statusColor,
                fontSize: 10,
              ),
            ),
          ),
        ),
        DataCell(
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColor.blue.withOpacity(0.2),
              elevation: 0,
            ),
            onPressed: () {},
            child: Text(
              "View",
              style: AppTextStyle.font12semibold.copyWith(
                color: AppColor.blue,
                fontSize: 12,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
