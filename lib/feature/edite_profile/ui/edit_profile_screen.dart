// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syrian_currency/core/constants/app_color.dart';
import 'package:syrian_currency/core/constants/app_text_style.dart';
import 'package:syrian_currency/core/helper/navigation.dart';
import 'package:syrian_currency/core/helper/snack_bar_helper.dart';
import 'package:syrian_currency/core/widgets/app_bottom.dart';
import 'package:syrian_currency/core/widgets/my_app_bar.dart';
import 'package:syrian_currency/core/widgets/options_card.dart';
import 'package:syrian_currency/core/widgets/profile_image_holder.dart';
import 'package:syrian_currency/feature/edite_profile/logic/edite_profile_cubit.dart';
import 'package:syrian_currency/feature/edite_profile/logic/edite_profile_state.dart';
import 'package:syrian_currency/feature/edite_profile/model/edit_profile_request_body.dart';
import 'package:syrian_currency/feature/edite_profile/widgets/profile_form.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

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
              child: BlocConsumer<EditeProfileCubit, EditProfileState>(
                listener: (context, state) {
                  if (state is EditProfileSuccess) {
                    context.pop();
                    SnackBarHelper.showSuccess(
                      context,
                      "Edit Successfuly done",
                    );
                  }
                  if (state is EditProfileFailure) {
                    SnackBarHelper.showError(context, "Edit Failed");
                  }
                },
                builder: (context, state) {
                  final cubit = context.read<EditeProfileCubit>();
                  final user = cubit.currentUser;
                  bool isLoading = state is EditProfileLoading;

                  if (state is EditProfileLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state is FetchProfileFailure) {
                    return Center(
                      child: Text(
                        state.error,
                        style: TextStyle(color: Colors.red),
                      ),
                    );
                  }
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        40.verticalSpace,
                        ProfileImageHolder(
                          imagePath:
                              cubit.selectedImage?.path ??
                              user?.avatar ??
                              "assets/images/profile_image.png",
                          icon: Icons.edit_outlined,
                          onTap: () {
                            cubit.pickImage();
                          },
                        ),
                        66.verticalSpace,
                        ProfileForm(
                          cubit: cubit,
                          formKey: cubit.formKey,
                          isLoading: state is BottomLoadingState,
                        ),
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
                                  if (cubit.formKey.currentState!.validate()) {
                                    cubit.editProfile(
                                      EditProfileRequestBody(
                                        fullName:
                                            cubit.firstNameController.text,
                                        avatar:
                                            cubit.selectedImage?.path ??
                                            "assets/images/profile_image.png",
                                      ),
                                    );
                                  }
                                },
                                isLoading: isLoading,
                              ),
                              24.verticalSpace,
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
