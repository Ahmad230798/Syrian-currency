import 'package:dartz/dartz.dart';
import 'package:syrian_currency/core/networking/api_constants.dart';
import 'package:syrian_currency/core/networking/api_error_handler.dart';
import 'package:syrian_currency/core/networking/api_service.dart';
import 'package:syrian_currency/feature/camera_scan/model/scanner_response_model.dart';

class ScanHistoryRepo {
  final ApiServices apiServices;

  ScanHistoryRepo(this.apiServices);

  Future<Either<Failure, List<ScanDataModel>>> getScanHistory() async {
    try {
      // تأكد من إضافة مسار الـ API في ApiConstants:
      // static const String scanHistory = "scanner/history/";
      final response = await apiServices.getData(url: ApiConstants.scanHistory);

      // تحويل البيانات القادمة إلى List of ScanDataModel
      List<ScanDataModel> historyList = (response['data'] as List)
          .map((item) => ScanDataModel.fromJson(item))
          .toList();

      return Right(historyList);
    } on ServerFailure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
