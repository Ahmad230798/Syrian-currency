import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:syrian_currency/core/models/user_model.dart';
import 'package:syrian_currency/feature/edite_profile/logic/edite_profile_state.dart';
import 'package:syrian_currency/feature/edite_profile/model/edit_profile_request_body.dart';
import 'package:syrian_currency/feature/edite_profile/repo/edit_profile_repo.dart';

class EditeProfileCubit extends Cubit<EditProfileState> {
  final EditProfileRepo repo;
  final firstNameController = TextEditingController();
  UserModel? currentUser;
  EditeProfileCubit(this.repo) : super(EditProfileInitial());
  final formKey = GlobalKey<FormState>();
  File? selectedImage;
  final ImagePicker _picker = ImagePicker();
  Future<void> pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        selectedImage = File(image.path);
        emit(const ProfileImagePickedState());
      }
    } catch (e) {
      emit(EditProfileFailure("فشل في اختيار الصورة"));
    }
  }

  Future<void> getProfileInfo() async {
    try {
      emit(EditProfileLoading());
      final result = await repo.getUserProfile();
      result.fold(
        (failure) => emit(FetchProfileFailure(failure.errorMessage)),
        (user) {
          fillControllers(user);
          emit(FetchProfileSuccess(user));
        },
      );
    } catch (e) {
      emit(FetchProfileFailure("حدث خطأ أثناء قراءة البيانات"));
    }
  }

  Future<void> editProfile(EditProfileRequestBody body) async {
    emit(BottomLoadingState());
    final result = await repo.editProfile(body);
    result.fold(
      (failure) => emit(EditProfileFailure(failure.errorMessage)),
      (success) => emit(EditProfileSuccess(success)),
    );
  }

  void fillControllers(UserModel profile) {
    currentUser = profile;
    firstNameController.text = profile.fullName;
  }
}
