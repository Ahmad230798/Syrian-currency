import 'package:equatable/equatable.dart';
import 'package:syrian_currency/core/models/user_model.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();
  @override
  List<Object?> get props => [];
}

class ProfileInit extends ProfileState {
  const ProfileInit();
}

class ProfileLoading extends ProfileState {
  const ProfileLoading();
}

class LogoutLoading extends ProfileState {
  const LogoutLoading();
}

class ProfileSuccess extends ProfileState {
  final UserModel user;
  const ProfileSuccess(this.user);
  @override
  List<Object?> get props => [user];
}

class LogoutSuccess extends ProfileState {
  const LogoutSuccess();
}

class ProfileFailure extends ProfileState {
  final String errorMessage;
  const ProfileFailure(this.errorMessage);
  @override
  List<Object?> get props => [errorMessage];
}

class LogoutFailure extends ProfileState {
  final String errorMessage;
  const LogoutFailure(this.errorMessage);
  @override
  List<Object?> get props => [errorMessage];
}
