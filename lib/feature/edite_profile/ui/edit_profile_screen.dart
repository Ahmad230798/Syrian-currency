// ignore_for_file: use_build_context_synchronously, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syrian_currency/core/constants/app_color.dart';
import 'package:syrian_currency/core/constants/app_text_style.dart';
import 'package:syrian_currency/core/helper/navigation.dart';
import 'package:syrian_currency/core/widgets/app_bottom.dart';
import 'package:syrian_currency/core/widgets/my_app_bar.dart';
import 'package:syrian_currency/core/widgets/options_card.dart';
import 'package:syrian_currency/core/widgets/profile_image_holder.dart';
import 'package:syrian_currency/feature/edite_profile/widgets/profile_form.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            MyAppBar(
              title: "Edit Profile",
              onBackTap: () {
                context.pop();
              },
            ),

            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    40.verticalSpace,
                    ProfileImageHolder(
                      imagePath: "assets/images/profile_image.png",
                      icon: Icons.edit_outlined,
                    ),
                    66.verticalSpace,
                    ProfileForm(),
                    32.verticalSpace,
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Security", style: AppTextStyle.font24bold),
                          17.verticalSpace,
                          OptionsCard(
                            widget: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: AppColor.blue.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: Icon(
                                Icons.lock_outline,
                                color: AppColor.blue,
                              ),
                            ),
                            text: "Change Password",
                          ),
                          100.verticalSpace,
                          AppBottom(
                            text: "Save Changes",
                            textcolor: Colors.black,
                            icon: Icons.check,
                            color: Colors.black,
                            onPressed: () {
                              setState(() {
                                isLoading = true;
                                Future.delayed(Duration(seconds: 3), () {
                                  context.pop();
                                });
                              });
                            },
                            isLoading: isLoading,
                          ),
                          24.verticalSpace,
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
