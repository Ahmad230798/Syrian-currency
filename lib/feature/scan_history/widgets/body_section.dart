import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syrian_currency/core/constants/app_color.dart';
import 'package:syrian_currency/core/constants/app_text_style.dart';
import 'package:syrian_currency/feature/camera_scan/model/scanner_response_model.dart';
import 'package:syrian_currency/feature/scan_history/logic/scan_history_cubit.dart';
import 'package:syrian_currency/feature/scan_history/logic/scan_history_state.dart';
import 'package:syrian_currency/feature/scan_history/widgets/scan_card.dart';

class BodySection extends StatefulWidget {
  const BodySection({super.key});

  @override
  State<BodySection> createState() => _BodySectionState();
}

class _BodySectionState extends State<BodySection> {
  int _selectedIndex = 0;
  final List<String> _options = ["All", "Genuine", "Counterfeit"];

  Widget _buildList(List<ScanDataModel> allScans) {
    // فلترة القائمة بناءً على التبويب المختار
    List<ScanDataModel> filteredList = [];
    if (_selectedIndex == 0) {
      filteredList = allScans;
    } else if (_selectedIndex == 1) {
      filteredList = allScans.where((scan) => scan.isGenuine).toList();
    } else if (_selectedIndex == 2) {
      filteredList = allScans.where((scan) => !scan.isGenuine).toList();
    }

    if (filteredList.isEmpty) {
      return Center(
        child: Padding(
          padding: EdgeInsets.only(top: 50.h),
          child: Text(
            "No scans found.",
            style: AppTextStyle.font14regular.copyWith(
              color: AppColor.grayText,
            ),
          ),
        ),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: filteredList.length,
      itemBuilder: (context, index) {
        return ScanCard(scanData: filteredList[index]);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 45.h,
          decoration: BoxDecoration(
            color: AppColor.mainContainerBackGround,
            borderRadius: BorderRadius.circular(25.r),
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              double itemWidth = constraints.maxWidth / _options.length;

              return Stack(
                children: [
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeInOut,
                    left: _selectedIndex * itemWidth,
                    top: 0,
                    bottom: 0,
                    child: Container(
                      width: itemWidth,
                      decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.circular(25.r),
                      ),
                    ),
                  ),
                  Row(
                    children: List.generate(_options.length, (index) {
                      return Expanded(
                        child: GestureDetector(
                          onTap: () => setState(() => _selectedIndex = index),
                          behavior: HitTestBehavior.opaque,
                          child: Center(
                            child: Text(
                              _options[index],
                              style: TextStyle(
                                color: _selectedIndex == index
                                    ? Colors.white
                                    : Colors.grey.shade400,
                                fontWeight: FontWeight.w500,
                                fontSize: 14.sp,
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              );
            },
          ),
        ),
        32.verticalSpace,

        // بناء حالة القائمة باستخدام Cubit
        BlocBuilder<ScanHistoryCubit, ScanHistoryState>(
          builder: (context, state) {
            if (state is ScanHistoryLoading) {
              return const Center(
                child: CircularProgressIndicator(color: AppColor.blue),
              );
            } else if (state is ScanHistoryFailure) {
              return Center(
                child: Text(
                  state.errorMessage,
                  style: TextStyle(color: AppColor.red),
                ),
              );
            } else if (state is ScanHistorySuccess) {
              return _buildList(state.historyList);
            }
            return const SizedBox();
          },
        ),
      ],
    );
  }
}
