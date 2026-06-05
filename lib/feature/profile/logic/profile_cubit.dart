import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syrian_currency/core/helper/navigation.dart';
import 'package:syrian_currency/core/networking/servicse.dart';
import 'package:syrian_currency/core/routing/routes.dart';

import 'package:syrian_currency/feature/profile/logic/profile_state.dart';
import 'package:syrian_currency/feature/profile/repo/profile_repo.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepo repo;
  ProfileCubit({required this.repo}) : super(ProfileInit());
  Future<void> getProfileInfo() async {
    emit(ProfileLoading());
    final result = await repo.getUserProfile();
    result.fold((failure) => emit(ProfileFailure(failure.errorMessage)), (
      user,
    ) {
      emit(ProfileSuccess(user));
    });
  }

  Future<void> emitLogoutStates(BuildContext context) async {
    emit(LogoutLoading());

    final result = await repo.logOut();

    result.fold(
      (failure) {
        // حالة الفشل: إظهار رسالة خطأ
        emit(LogoutFailure(failure.errorMessage));
      },
      (successResponse) async {
        // حالة النجاح:
        // 1. مسح التوكنز والصلاحيات من الذاكرة
        await SharedPreferencesService().clearTokens();

        emit(LogoutSuccess());

        // 2. توجيه المستخدم إلى شاشة تسجيل الدخول
        if (context.mounted) {
          context.pushNamedAndRemoveUntil(Routes.logIn);
        }
      },
    );
  }
}
