import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:syrian_currency/feature/auth/model/signup_model/signup_response_body.dart';

class SignupState extends Equatable {
  const SignupState();
  @override
  List<Object?> get props => [];
}

class SignupInit extends SignupState {
  const SignupInit();
}

class SignupLoading extends SignupState {
  const SignupLoading();
}

class SignupPasswordVisibilityChanged extends SignupState {
  final bool isObscure;
  const SignupPasswordVisibilityChanged(this.isObscure);
  @override
  List<Object?> get props => [isObscure];
}

class SignupSuccess extends SignupState {
  final SignupResponseBody signupResponseBody;
  const SignupSuccess(this.signupResponseBody);
  @override
  List<Object?> get props => [signupResponseBody];
}

class SignupFailure extends SignupState {
  final String errorMessage;
  const SignupFailure(this.errorMessage);
  @override
  List<Object?> get props => [errorMessage];
}
