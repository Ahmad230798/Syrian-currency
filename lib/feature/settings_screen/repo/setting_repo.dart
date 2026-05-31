import 'package:dartz/dartz.dart';
import 'package:syrian_currency/core/models/user_model.dart';
import 'package:syrian_currency/core/networking/api_constants.dart';
import 'package:syrian_currency/core/networking/api_error_handler.dart';
import 'package:syrian_currency/core/networking/api_service.dart';

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
}
