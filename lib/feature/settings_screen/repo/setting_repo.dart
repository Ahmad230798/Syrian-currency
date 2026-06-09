import 'package:dartz/dartz.dart';
import 'package:syrian_currency/core/models/user_model.dart';
import 'package:syrian_currency/core/networking/api_constants.dart';
import 'package:syrian_currency/core/networking/api_error_handler.dart';
import 'package:syrian_currency/core/networking/api_service.dart';
import 'package:syrian_currency/core/networking/servicse.dart';

class SettingRepo {
  final ApiServices _apiServices;
  SettingRepo(this._apiServices);
  UserModel? currentUser;
  Future<Either<Failure, UserModel>> getUserInfo() async {
    try {
      final response = await _apiServices.getData(
        url: ApiConstants.userProfile,
      );
      final user = UserModel.fromJson(response);
      currentUser = user;
      return Right(user);
    } on ServerFailure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, dynamic>> logOut() async {
    try {
      // 1. جلب الـ Refresh Token من الذاكرة المحلية
      final prefService = SharedPreferencesService();
      final String? refreshToken = await prefService.getRefreshToken();

      // التحقق من وجود التوكن لتجنب إرسال طلب فارغ
      if (refreshToken == null) {
        return Left(ServerFailure("لا يوجد جلسة نشطة لتسجيل الخروج."));
      }

      // 2. إرسال الطلب مع تمرير الـ Body الذي يحتوي على التوكن
      final response = await _apiServices.postData(
        url: ApiConstants.logout,
        body: {"refresh": refreshToken},
      );

      return Right(response);
    } on ServerFailure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
