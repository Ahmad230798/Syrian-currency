// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:syrian_currency/core/constants/app_color.dart';
import 'package:syrian_currency/core/constants/app_text_style.dart';

class AdminScanHistoryTab extends StatelessWidget {
  const AdminScanHistoryTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "System Scan Ledger",
            style: AppTextStyle.font24bold.copyWith(fontSize: 24),
          ),
          Text(
            "Global audit of all verification requests across the network.",
            style: AppTextStyle.font14regular.copyWith(fontSize: 14),
          ),
          const SizedBox(height: 24.0),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColor.mainContainerBackGround,
              borderRadius: BorderRadius.circular(16.0),
              border: Border.all(color: Colors.white.withOpacity(0.05)),
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal, // يمنع خروج الجدول عن الشاشة
              child: DataTable(
                headingRowColor: MaterialStateProperty.all(
                  Colors.white.withOpacity(0.02),
                ),
                columns: [
                  DataColumn(
                    label: Text(
                      "SCAN ID & DATE",
                      style: AppTextStyle.font10bold.copyWith(
                        color: AppColor.grayText,
                        fontSize: 10,
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      "METRICS",
                      style: AppTextStyle.font10bold.copyWith(
                        color: AppColor.grayText,
                        fontSize: 10,
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      "VERDICT",
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
                  _buildHistoryRow(
                    "SCN-9942-A",
                    "Oct 27",
                    "0.012",
                    "98%",
                    "Genuine",
                    AppColor.green,
                  ),
                  _buildHistoryRow(
                    "SCN-9941-F",
                    "Oct 27",
                    "0.845",
                    "92%",
                    "Counterfeit",
                    Colors.redAccent,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  DataRow _buildHistoryRow(
    String id,
    String date,
    String mse,
    String conf,
    String verdict,
    Color color,
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "MSE: $mse",
                style: AppTextStyle.font12semibold.copyWith(
                  color: color,
                  fontSize: 12,
                ),
              ),
              Text(
                "$conf CONF",
                style: AppTextStyle.font10bold.copyWith(
                  color: AppColor.grayText,
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ),
        DataCell(
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Text(
              verdict.toUpperCase(),
              style: AppTextStyle.font10bold.copyWith(
                color: color,
                fontSize: 10,
              ),
            ),
          ),
        ),
        DataCell(
          TextButton(
            onPressed: () {},
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
