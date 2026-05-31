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
    if (state is HomeSuccess) {
      final currentState = state as HomeSuccess;
      // 🌟 3. نرسل الحالة مع عكس قيمة isMore الحالية
      emit(
        HomeSuccess(
          currentState.historyList,
          isMore: !currentState.isMore, // عكس القيمة السابقة
        ),
      );
    }
  }

  Future<void> pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        selectedImage = File(image.path);
        performScan(selectedImage!);
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
    emit(const ScanLoading());

    // 2. إرسال الصورة للسيرفر وانتظار النتيجة
    final result = await _repo.scanCurrency(imageFile);

    // 3. معالجة النتيجة
    result.fold(
      (failure) {
        emit(ScannerFailure(failure.errorMessage));
        getScanHistory(); // 🌟 إعادة جلب السجل لتعود الشاشة لوضعها الطبيعي
      },
      (success) {
        if (success.success == true && success.data != null) {
          emit(ScannerSuccess(success));
          getScanHistory(); // 🌟 السيرفر انتهى وحفظ الفحص، الآن نجلب السجل الجديد وسوف يظهر فوراً!
        } else {
          emit(ScannerFailure(success.message ?? "فشل تحليل الصورة"));
          getScanHistory(); // 🌟 إعادة جلب السجل لتعود الشاشة لوضعها الطبيعي
        }
      },
    );
  }
}
