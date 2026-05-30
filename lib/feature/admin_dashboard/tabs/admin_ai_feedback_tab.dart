// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:syrian_currency/core/constants/app_color.dart';
import 'package:syrian_currency/core/constants/app_text_style.dart';

class AdminAiFeedbackTab extends StatelessWidget {
  const AdminAiFeedbackTab({super.key});

  @override
  Widget build(BuildContext context) {
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
                    style: AppTextStyle.font14regular.copyWith(fontSize: 14),
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
                "Pending Reports",
                "24",
                Icons.pending_actions,
                Colors.amber,
              ),
              const SizedBox(width: 16.0),
              _buildStatCard(
                "Reviewed",
                "142",
                Icons.rate_review,
                AppColor.blue,
              ),
              const SizedBox(width: 16.0),
              _buildStatCard("Resolved", "856", Icons.task_alt, AppColor.green),
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
              child: _buildFeedbackTable(),
            ),
          ),
        ],
      ),
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

  Widget _buildFeedbackTable() {
    return DataTable(
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
      rows: [
        _buildFeedbackRow(
          "#F-102",
          "Oct 24",
          "Dr. Sarah",
          "Counterfeit",
          "Pending",
          Colors.redAccent,
          Colors.amber,
        ),
        _buildFeedbackRow(
          "#F-101",
          "Oct 24",
          "Prof. M. Chen",
          "Genuine",
          "Reviewed",
          AppColor.green,
          AppColor.blue,
        ),
      ],
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
              status,
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
              "Resolve",
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
