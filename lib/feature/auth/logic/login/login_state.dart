import 'package:equatable/equatable.dart';
import 'package:syrian_currency/feature/auth/model/login_model/login_response_body.dart';

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

class LoginSuccess extends LoginState {
  final LoginResponseBody loginResponseBody;
  const LoginSuccess(this.loginResponseBody);
  @override
  List<Object?> get props => [loginResponseBody];
}
class LoginFailure extends LoginState {
  final String errorMessage;
  const LoginFailure(this.errorMessage);
  @override
  List<Object?>get props=>[errorMessage];
}
