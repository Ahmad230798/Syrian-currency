import 'package:syrian_currency/core/networking/api_constants.dart';
import 'package:syrian_currency/core/networking/api_error_handler.dart';
import 'package:syrian_currency/core/networking/api_service.dart';
import 'package:dartz/dartz.dart';
import 'package:syrian_currency/feature/auth/model/signup_model/signup_request_body.dart';
import 'package:syrian_currency/feature/auth/model/signup_model/signup_response_body.dart';

class SignupRepo {
  final ApiServices apiServices;
  SignupRepo(this.apiServices);
  Future<Either<Failure, SignupResponseBody>> signUp(
    SignupRequestBody signupRequestBody,
  ) async {
    try {
      final response = await apiServices.postData(
        url: ApiConstants.register,
        body: signupRequestBody.toJson(),
      );
      final signupResponseBody = SignupResponseBody.fromJson(response);
      return Right(signupResponseBody);
    } on ServerFailure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
