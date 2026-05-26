import 'package:dartz/dartz.dart';
import 'package:syrian_currency/core/models/user_model.dart';
import 'package:syrian_currency/core/networking/api_constants.dart';
import 'package:syrian_currency/core/networking/api_error_handler.dart';
import 'package:syrian_currency/core/networking/api_service.dart';

class ProfileRepo {
  final ApiServices apiServices;
  ProfileRepo(this.apiServices);
  Future<Either<Failure, UserModel>> getUserProfile() async {
    try {
      final response = await apiServices.getData(url: ApiConstants.userProfile);
      final userProfile = UserModel.fromJson(response);
      return Right(userProfile);
    } on ServerFailure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
