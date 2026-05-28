import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:syrian_currency/core/networking/api_constants.dart';
import 'package:syrian_currency/core/networking/api_error_handler.dart';
import 'package:syrian_currency/core/networking/api_service.dart';
import 'package:syrian_currency/core/networking/servicse.dart';
import 'package:syrian_currency/feature/camera_scan/model/scanner_response_model.dart';

class ScannerRepo {
  final ApiServices apiServices;
  final SharedPreferencesService prefService;

  ScannerRepo(this.apiServices, this.prefService);

  Future<Either<Failure, ScannerResponseModel>> scanCurrency(
    File imageFile,
  ) async {
    try {
      // تجهيز الصورة كـ FormData
      FormData formData = FormData.fromMap({
        "image": await MultipartFile.fromFile(imageFile.path),
      });

      // جلب مُعرّف الجهاز للزوار
      String deviceId = await prefService.getDeviceId();

      // إرسال الطلب مع إضافة X-Device-Id للـ Headers
      final response = await apiServices.postFormData(
        url: ApiConstants.scannerScan,
        data: formData,
        headers: {'X-Device-Id': deviceId},
      );

      final scannerResponse = ScannerResponseModel.fromJson(response);
      return Right(scannerResponse);
    } on ServerFailure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
