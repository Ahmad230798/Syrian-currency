import 'package:dartz/dartz.dart';
import 'package:syrian_currency/core/networking/api_constants.dart';
import 'package:syrian_currency/core/networking/api_error_handler.dart';
import 'package:syrian_currency/core/networking/api_service.dart';
import '../models/my_feedback_model.dart';

class MyReportsRepo {
  final ApiServices _apiServices;
  MyReportsRepo(this._apiServices);

  Future<Either<Failure, List<MyFeedbackModel>>> getMyReports() async {
    try {
      final response = await _apiServices.getData(
        url: ApiConstants.myFeedbacks,
      );
      List data = response is Map ? (response['data'] ?? response) : response;

      List<MyFeedbackModel> reports = data
          .map((json) => MyFeedbackModel.fromJson(json))
          .toList();
      return Right(reports);
    } on ServerFailure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
