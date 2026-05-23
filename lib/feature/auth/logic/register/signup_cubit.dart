import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syrian_currency/feature/auth/logic/register/signup_state.dart';
import 'package:syrian_currency/feature/auth/model/signup_model/signup_request_body.dart';
import 'package:syrian_currency/feature/auth/repo/signup_repo.dart';

class SignupCubit extends Cubit<SignupState> {
  bool isObscureText = true;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final fullNameController = TextEditingController();
  final SignupRepo signupRepo;
  void togglePasswordVisibility() {
    isObscureText = !isObscureText;
    emit(SignupPasswordVisibilityChanged(isObscureText));
  }

  SignupCubit(this.signupRepo) : super(SignupInit());
  Future<void> signUp(SignupRequestBody body) async {
    emit(SignupLoading());
    final result = await signupRepo.signUp(body);
    result.fold(
      (failure) => emit(SignupFailure(failure.errorMessage)),
      (success) => emit(SignupSuccess(success)),
    );
  }
}
