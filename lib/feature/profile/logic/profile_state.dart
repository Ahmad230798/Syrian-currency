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

class ProfileSuccess extends ProfileState {
  final UserModel user;
  const ProfileSuccess(this.user);
  @override
  List<Object?> get props => [user];
}

class ProfileFailure extends ProfileState {
  final String errorMessage;
  const ProfileFailure(this.errorMessage);
  @override
  List<Object?> get props => [errorMessage];
}
