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

  // 👈 غيرنا نوع الإرجاع ليصبح String (والذي سيمثل الـ Role)
  Future<Either<Failure, String>> login(
    LoginRequestBody loginRequestBody,
  ) async {
    try {
      // 1. تسجيل الدخول وجلب التوكن
      final response = await apiServices.postData(
        url: ApiConstants.login,
        body: loginRequestBody.toJson(),
      );
      final loginResponseBody = LoginResponseBody.fromJson(response);

      // حفظ التوكن في الجهاز
      await pref.saveTokens(
        accessToken: loginResponseBody.access,
        refreshToken: loginResponseBody.refresh,
      );

      // 2. جلب بيانات البروفايل لمعرفة الصلاحية (Role)
      final profileResponse = await apiServices.getData(
        url: ApiConstants.userProfile,
        // نمرر التوكن يدوياً هنا لضمان سرعة جلبه بعد تسجيل الدخول مباشرة
        headers: {'Authorization': 'Bearer ${loginResponseBody.access}'},
      );

      final String userRole = profileResponse['role'] ?? 'user';

      // 3. إرجاع الصلاحية للـ Cubit
      return Right(userRole);
    } on ServerFailure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
