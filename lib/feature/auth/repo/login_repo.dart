import 'package:dartz/dartz.dart';
import 'package:syrian_currency/core/networking/api_constants.dart';
import 'package:syrian_currency/core/networking/api_error_handler.dart';
import 'package:syrian_currency/core/networking/api_service.dart';
import 'package:syrian_currency/core/networking/servicse.dart';
import 'package:syrian_currency/feature/auth/model/login_model/login_request_body.dart';
import 'package:syrian_currency/feature/auth/model/login_model/login_response_body.dart';

class LoginRepo {
  final ApiServices apiServices;
  final SharedPreferencesService pref;
  LoginRepo(this.apiServices, this.pref);
  Future<Either<Failure, LoginResponseBody>> login(
    LoginRequestBody loginRequestBody,
  ) async {
    try {
      final response = await apiServices.postData(
        url: ApiConstants.login,
        body: loginRequestBody.toJson(),
      );
      final loginResponseBody = LoginResponseBody.fromJson(response);
      await pref.saveTokens(
        accessToken: loginResponseBody.access,
        refreshToken: loginResponseBody.refresh,
      );
      return Right(loginResponseBody);
    } on ServerFailure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
