import 'package:dartz/dartz.dart';
import 'package:syrian_currency/core/networking/api_constants.dart';
import 'package:syrian_currency/core/networking/api_error_handler.dart';
import 'package:syrian_currency/core/networking/api_service.dart';

class FeedbackRepo {
  final ApiServices _apiServices;
  FeedbackRepo(this._apiServices);

  Future<Either<Failure, String>> submitFeedback({
    required int scanId,
    required String note,
  }) async {
    try {
      final response = await _apiServices.postData(
        url: ApiConstants.createFeedback,
        body: {"scan": scanId, "note": note},
      );
      // إرجاع رسالة النجاح من الباك إند
      return Right(response['message'] ?? "Report submitted successfully");
    } on ServerFailure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
