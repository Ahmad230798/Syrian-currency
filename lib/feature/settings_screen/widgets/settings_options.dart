import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syrian_currency/core/constants/app_color.dart';
import 'package:syrian_currency/core/constants/app_text_style.dart';
import 'package:syrian_currency/core/widgets/options_card.dart';
import 'package:flutter/cupertino.dart';

class SettingsOptions extends StatefulWidget {
  const SettingsOptions({super.key});

  @override
  State<SettingsOptions> createState() => _SettingsOptionsState();
}

class _SettingsOptionsState extends State<SettingsOptions> {
  bool pushNotificationSwitched = false;
  bool biometricSwitched = false;
  bool darkModewitched = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 28.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "APP SETTINGS",
            style: AppTextStyle.font10bold.copyWith(
              fontWeight: FontWeight.w900,
              height: 10 / 10,
              letterSpacing: 1,
              color: AppColor.blue,
            ),
          ),
          16.verticalSpace,
          ClipRRect(
            borderRadius: BorderRadius.circular(16.r),
            child: Container(
              width: 1.sw,
              decoration: BoxDecoration(
                border: Border.all(color: AppColor.grayText, width: 0.5.w),
                borderRadius: BorderRadius.circular(16.r),
                color: AppColor.mainContainerBackGround,
              ),
              child: Column(
                children: [
                  OptionsCard(
                    widget: Container(
                      width: 40.w,
                      height: 40.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                        color: AppColor.blue.withOpacity(0.1),
                      ),
                      child: Icon(
                        Icons.notifications_none,
                        color: AppColor.blue,
                      ),
                    ),
                    text: "Push Notifications",
                    icon: CupertinoSwitch(
                      value: pushNotificationSwitched,
                      activeTrackColor: AppColor.blue,
                      onChanged: (bool newValue) {
                        setState(() {
                          pushNotificationSwitched = newValue;
                        });
                      },
                    ),
                  ),
                  Divider(color: AppColor.grayText, thickness: 0.5),
                  OptionsCard(
                    widget: Container(
                      width: 40.w,
                      height: 40.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                        color: AppColor.blue.withOpacity(0.1),
                      ),
                      child: Icon(Icons.fingerprint, color: AppColor.blue),
                    ),
                    text: "Biometric Unlock",
                    icon: CupertinoSwitch(
                      value: biometricSwitched,
                      activeTrackColor: AppColor.blue,
                      onChanged: (bool newValue) {
                        setState(() {
                          biometricSwitched = newValue;
                        });
                      },
                    ),
                  ),
                  Divider(color: AppColor.grayText, thickness: 0.5),
                  OptionsCard(
                    widget: Container(
                      width: 40.w,
                      height: 40.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                        color: AppColor.blue.withOpacity(0.1),
                      ),
                      child: Icon(
                        Icons.dark_mode_outlined,
                        color: AppColor.blue,
                      ),
                    ),
                    text: "Dark Mode",
                    icon: CupertinoSwitch(
                      value: darkModewitched,
                      activeTrackColor: AppColor.blue,
                      onChanged: (bool newValue) {
                        setState(() {
                          darkModewitched = newValue;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          32.verticalSpace,
          Text(
            "Security",
            style: AppTextStyle.font10bold.copyWith(
              fontWeight: FontWeight.w900,
              height: 10 / 10,
              letterSpacing: 1,
              color: AppColor.blue,
            ),
          ),
          16.verticalSpace,
          ClipRRect(
            borderRadius: BorderRadius.circular(16.r),
            child: Container(
              width: 1.sw,
              decoration: BoxDecoration(
                border: Border.all(color: AppColor.grayText, width: 0.5.w),
                borderRadius: BorderRadius.circular(16.r),
                color: AppColor.mainContainerBackGround,
              ),
              child: Column(
                children: [
                  OptionsCard(
                    widget: Container(
                      width: 40.w,
                      height: 40.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                        color: AppColor.blue.withOpacity(0.1),
                      ),
                      child: Icon(
                        Icons.lock_reset_rounded,
                        color: AppColor.blue,
                      ),
                    ),
                    text: "Change Password",
                  ),
                  Divider(color: AppColor.grayText, thickness: 0.5),
                  OptionsCard(
                    widget: Container(
                      width: 40.w,
                      height: 40.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                        color: AppColor.blue.withOpacity(0.1),
                      ),
                      child: Icon(Icons.devices, color: AppColor.blue),
                    ),
                    text: "Devices Managment",
                  ),
                ],
              ),
            ),
          ),
          32.verticalSpace,
          Text(
            "Support",
            style: AppTextStyle.font10bold.copyWith(
              fontWeight: FontWeight.w900,
              height: 10 / 10,
              letterSpacing: 1,
              color: AppColor.blue,
            ),
          ),
          16.verticalSpace,
          ClipRRect(
            borderRadius: BorderRadius.circular(16.r),
            child: Container(
              width: 1.sw,
              decoration: BoxDecoration(
                border: Border.all(color: AppColor.grayText, width: 0.5.w),
                borderRadius: BorderRadius.circular(16.r),
                color: AppColor.mainContainerBackGround,
              ),
              child: Column(
                children: [
                  OptionsCard(
                    widget: Container(
                      width: 40.w,
                      height: 40.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                        color: AppColor.blue.withOpacity(0.1),
                      ),
                      child: Icon(
                        Icons.help_center_outlined,
                        color: AppColor.blue,
                      ),
                    ),
                    text: "Help Center",
                  ),
                  Divider(color: AppColor.grayText, thickness: 0.5),
                  OptionsCard(
                    widget: Container(
                      width: 40.w,
                      height: 40.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                        color: AppColor.blue.withOpacity(0.1),
                      ),
                      child: Icon(
                        Icons.bug_report_outlined,
                        color: AppColor.blue,
                      ),
                    ),
                    text: "Report a Bug",
                  ),
                  Divider(color: AppColor.grayText, thickness: 0.5),
                  OptionsCard(
                    widget: Container(
                      width: 40.w,
                      height: 40.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                        color: AppColor.blue.withOpacity(0.1),
                      ),
                      child: Icon(Icons.info_outline, color: AppColor.blue),
                    ),
                    text: "About App",
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
