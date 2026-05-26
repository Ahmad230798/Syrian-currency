import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syrian_currency/feature/auth/logic/login/login_state.dart';
import 'package:syrian_currency/feature/auth/model/login_model/login_request_body.dart';
import 'package:syrian_currency/feature/auth/repo/login_repo.dart';

class LoginCubit extends Cubit<LoginState> {
  bool isObscureText = true;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  void togglePasswordVisibility() {
    isObscureText = !isObscureText;
    emit(LoginPasswordVisibilityChanged(isObscureText));
  }

  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    return super.close();
  }

  final LoginRepo loginRepo;
  LoginCubit(this.loginRepo) : super(LoginInit());
  Future<void> login(LoginRequestBody body) async {
    emit(LoginLoading());
    final result = await loginRepo.login(body);
    result.fold(
      (failure) => emit(LoginFailure(failure.errorMessage)),
      (success) => emit(LoginSuccess(success)),
    );
  }
}
