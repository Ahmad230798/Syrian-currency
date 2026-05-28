import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:syrian_currency/core/models/user_model.dart';
import 'package:syrian_currency/core/networking/api_constants.dart';
import 'package:syrian_currency/core/networking/api_error_handler.dart';
import 'package:syrian_currency/core/networking/api_service.dart';
import 'package:syrian_currency/feature/edite_profile/model/edit_profile_request_body.dart';

class EditProfileRepo {
  final ApiServices apiServices;
  UserModel? oldUser;

  EditProfileRepo(this.apiServices);
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

  Future<Either<Failure, UserModel>> editProfile(
    EditProfileRequestBody body,
  ) async {
    try {
      FormData formData = FormData.fromMap({"full_name": body.fullName});
      if (body.avatar != null && !body.avatar!.contains('assets')) {
        formData.files.add(
          MapEntry("avatar", await MultipartFile.fromFile(body.avatar!)),
        );
      }
      final response = await apiServices.putData(
        url: ApiConstants.userProfile,
        body: formData,
      );

      final updatedUser = UserModel.fromJson(response);

      oldUser = updatedUser;

      return Right(updatedUser);
    } on ServerFailure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
