import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syrian_currency/core/helper/navigation.dart';
import 'package:syrian_currency/core/widgets/my_app_bar.dart';
import 'package:syrian_currency/feature/scan_history/widgets/body_section.dart';

class ScanHistoryScreen extends StatelessWidget {
  final bool isFromBottomNav;
  const ScanHistoryScreen({super.key, this.isFromBottomNav = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            MyAppBar(
              title: "Scan History",
              suffixsIcon: isFromBottomNav ? SizedBox() : null,
              onBackTap: () {
                context.pop();
              },
            ),
            24.verticalSpace,
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: BodySection(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
