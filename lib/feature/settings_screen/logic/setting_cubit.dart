import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syrian_currency/core/helper/navigation.dart';
import 'package:syrian_currency/core/networking/servicse.dart';
import 'package:syrian_currency/core/routing/routes.dart';
import 'package:syrian_currency/feature/settings_screen/logic/setting_state.dart';
import 'package:syrian_currency/feature/settings_screen/repo/setting_repo.dart';

class SettingCubit extends Cubit<SettingState> {
  final SettingRepo repo;
  SettingCubit({required this.repo}) : super(const SettingInitState());

  Future<void> getUsernfo() async {
    emit(SettingLoadingState());
    final result = await repo.getUserInfo();
    result.fold((failure) => emit(SettingFailureState(failure.errorMessage)), (
      user,
    ) {
      emit(SettingSuccessState(user));
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
