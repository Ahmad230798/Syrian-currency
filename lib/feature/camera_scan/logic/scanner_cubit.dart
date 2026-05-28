import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syrian_currency/feature/camera_scan/logic/scanner_state.dart';
import 'package:syrian_currency/feature/camera_scan/repo/scanner_repo.dart';

class ScannerCubit extends Cubit<ScannerState> {
  final ScannerRepo scannerRepo;

  ScannerCubit(this.scannerRepo) : super(ScannerInitial());

  Future<void> performScan(File imageFile) async {
    // 1. إخبار الواجهة بإظهار شاشة التحميل
    emit(ScannerLoading());

    // 2. إرسال الصورة للسيرفر
    final result = await scannerRepo.scanCurrency(imageFile);

    // 3. معالجة النتيجة القادمة من dartz (Either)
    result.fold(
      (failure) {
        // خطأ في الاتصال أو السيرفر (مثل 400، 401، 500)
        emit(ScannerFailure(failure.errorMessage));
      },
      (success) {
        // نجاح الاتصال، لكن نتحقق هل الذكاء الاصطناعي وجد عملة فعلاً؟
        if (success.success == true && success.data != null) {
          emit(ScannerSuccess(success));
        } else {
          // الذكاء الاصطناعي أرجع خطأ (مثلاً: "الصورة لا تحتوي على عملة سورية")
          emit(ScannerFailure(success.message ?? "فشل تحليل الصورة"));
        }
      },
    );
  }
}
