import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syrian_currency/core/networking/api_constants.dart'; // 👈 تأكد من وجود هذا الاستيراد
import 'package:syrian_currency/feature/camera_scan/logic/scanner_state.dart';
import 'package:syrian_currency/feature/camera_scan/repo/scanner_repo.dart';

class ScannerCubit extends Cubit<ScannerState> {
  final ScannerRepo scannerRepo;

  ScannerCubit(this.scannerRepo) : super(ScannerInitial());

  Future<void> performScan(File imageFile) async {
    emit(ScannerLoading());

    final result = await scannerRepo.scanCurrency(imageFile);

    result.fold(
      (failure) {
        emit(ScannerFailure(failure.errorMessage));
      },
      (success) async {
        // 👈 أضفنا async هنا
        if (success.success == true && success.data != null) {
          bool isUserExpert = false;
          try {
            // 👈 خدعة ذكية: نجلب بروفايل المستخدم بسرعة للتأكد من صلاحيته
            final profile = await scannerRepo.apiServices.getData(
              url: ApiConstants.userProfile,
            );
            if (profile['role'] == 'expert') {
              isUserExpert = true;
            }
          } catch (e) {
            // سيتم تجاهل الخطأ بصمت إذا كان المستخدم زائر (Guest) ولا يملك توكن
          }

          // نمرر النتيجة والصلاحية معاً!
          emit(ScannerSuccess(success, isExpert: isUserExpert));
        } else {
          emit(ScannerFailure(success.message ?? "فشل تحليل الصورة"));
        }
      },
    );
  }
}
