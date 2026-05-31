import 'package:equatable/equatable.dart';

class LoginState extends Equatable {
  const LoginState();
  @override
  List<Object?> get props => [];
}

class LoginInit extends LoginState {
  const LoginInit();
}

class LoginLoading extends LoginState {
  const LoginLoading();
}

class LoginPasswordVisibilityChanged extends LoginState {
  final bool isObscure;
  const LoginPasswordVisibilityChanged(this.isObscure);
  @override
  List<Object?> get props => [isObscure];
}

class LoginSuccess extends LoginState {
  final String role; // 👈 أضفنا الصلاحية هنا بدل الموديل القديم
  const LoginSuccess(this.role);
  @override
  List<Object?> get props => [role];
}

class LoginFailure extends LoginState {
  final String errorMessage;
  const LoginFailure(this.errorMessage);
  @override
  List<Object?> get props => [errorMessage];
}
