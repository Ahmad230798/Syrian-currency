import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:syrian_currency/feature/camera_scan/model/scanner_response_model.dart';
import 'package:syrian_currency/feature/home/repo/home_repo.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepo _repo;
  bool more = false;
  File? selectedImage;
  final ImagePicker _picker = ImagePicker();
  HomeCubit(HomeRepo repo) : _repo = repo, super(HomeInitial());
  void toggleMoreState() {
    more = !more;
    if (state is HomeSuccess) {
      emit(HomeSuccess((state as HomeSuccess).historyList));
    }
  }

  Future<void> pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        selectedImage = File(image.path);
        performScan(selectedImage!);
        getScanHistory();
        // emit(const ImagePickedState());
      }
    } catch (e) {
      emit(ImageFailureState(errorMessage: "فشل في اختيار الصورة"));
    }
  }

  Future<void> getScanHistory() async {
    emit(HomeLoading());
    final result = await _repo.getHistoryData();
    result.fold(
      (failure) => emit(HomeFailure(failure.errorMessage)),
      (history) => emit(HomeSuccess(history)),
    );
  }

  Future<void> performScan(File imageFile) async {
    // 1. إخبار الواجهة بإظهار شاشة التحميل
    emit(ScanLoading());

    // 2. إرسال الصورة للسيرفر
    final result = await _repo.scanCurrency(imageFile);

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
