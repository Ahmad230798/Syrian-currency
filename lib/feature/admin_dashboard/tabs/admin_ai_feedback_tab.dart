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
              .where((f) => f.status == 'resolved' || f.status == 'rejected')
              .length;

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
                            color: AppColor.grayText,
                          ),
                        ),
                      ],
                    ),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.mainContainerBackGround,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 18,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        side: BorderSide(color: Colors.white.withOpacity(0.1)),
                      ),
                      icon: const Icon(
                        Icons.download,
                        color: AppColor.blue,
                        size: 20,
                      ),
                      label: Text(
                        "Export CSV",
                        style: AppTextStyle.font14regular.copyWith(
                          color: AppColor.blue,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () {
                        // TODO: برمجة التصدير لاحقاً
                      },
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
                      "Resolved / Rejected",
                      "$resolvedCount",
                      Icons.task_alt,
                      AppColor.green,
                    ),
                  ],
                ),
                const SizedBox(height: 32.0),

                // 🌟 حاوية الجدول مع الإصلاح الشامل للتمدد
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColor.mainContainerBackGround,
                    borderRadius: BorderRadius.circular(16.0),
                    border: Border.all(color: Colors.white.withOpacity(0.05)),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16.0),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: ConstrainedBox(
                        // 🌟 إجبار الجدول على التمدد ليملأ الشاشة بدلاً من الانكماش
                        constraints: BoxConstraints(
                          minWidth: MediaQuery.of(context).size.width - 320,
                        ),
                        child: state.feedbacks.isEmpty
                            ? Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(40.0),
                                  child: Text(
                                    "No feedback reports submitted yet.",
                                    style: AppTextStyle.font14regular.copyWith(
                                      color: AppColor.grayText,
                                    ),
                                  ),
                                ),
                              )
                            : DataTable(
                                headingRowColor: WidgetStateProperty.all(
                                  Colors.white.withOpacity(0.02),
                                ),
                                dataRowMaxHeight: 75.0, // توحيد الارتفاع
                                dataRowMinHeight: 75.0,
                                dividerThickness: 0.5,
                                columnSpacing:
                                    60.0, // 🌟 زيادة المسافة بين الأعمدة ليتوزع المحتوى بشكل أنيق
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
                                    f.createdAt.substring(0, 10),
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
                  ),
                ),
                const SizedBox(height: 50.0), // مساحة للتنفس بالأسفل
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
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(height: 16.0),
            Text(
              title,
              style: AppTextStyle.font14regular.copyWith(
                color: AppColor.grayText,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 4.0),
            Text(value, style: AppTextStyle.font24bold.copyWith(fontSize: 28)),
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
              const SizedBox(height: 4.0),
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
          Row(
            children: [
              CircleAvatar(
                radius: 14,
                backgroundColor: Colors.purpleAccent.withOpacity(0.2),
                child: Text(
                  name.substring(0, 1).toUpperCase(),
                  style: const TextStyle(
                    color: Colors.purpleAccent,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 12.0),
              Text(
                name,
                style: AppTextStyle.font14regular.copyWith(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        DataCell(
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12.0,
              vertical: 6.0,
            ),
            decoration: BoxDecoration(
              color: verdictColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(6.0),
              border: Border.all(color: verdictColor.withOpacity(0.3)),
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
            padding: const EdgeInsets.symmetric(
              horizontal: 12.0,
              vertical: 6.0,
            ),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(6.0),
              border: Border.all(color: statusColor.withOpacity(0.3)),
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
          TextButton(
            onPressed: () {
              // TODO: برمجة عرض تفاصيل التقرير للإدمن لاحقاً
            },
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              backgroundColor: AppColor.blue.withOpacity(0.1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            child: Text(
              "View Details",
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
