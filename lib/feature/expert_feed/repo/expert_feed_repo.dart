import 'package:dartz/dartz.dart';
import 'package:syrian_currency/core/networking/api_constants.dart';
import 'package:syrian_currency/core/networking/api_error_handler.dart';
import 'package:syrian_currency/core/networking/api_service.dart';
import 'package:syrian_currency/feature/camera_scan/model/scanner_response_model.dart';

class ExpertFeedRepo {
  final ApiServices _apiServices;
  ExpertFeedRepo(this._apiServices);

  Future<Either<Failure, List<ScanDataModel>>> getCommunityFeed() async {
    try {
      final response = await _apiServices.getData(url: ApiConstants.expertFeed);

      // استخراج المصفوفة من الـ response['data']
      List data = response is Map ? (response['data'] ?? response) : response;

      // تحويلها إلى قائمة من موديل الفحص الموجود مسبقاً
      List<ScanDataModel> scans = data
          .map((json) => ScanDataModel.fromJson(json))
          .toList();
      return Right(scans);
    } on ServerFailure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
