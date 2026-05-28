import 'package:equatable/equatable.dart';
import 'package:syrian_currency/core/models/user_model.dart';

abstract class EditProfileState extends Equatable {
  const EditProfileState();
  @override
  List<Object?> get props => [];
}

class EditProfileInitial extends EditProfileState {
  const EditProfileInitial();
}

class EditProfileLoading extends EditProfileState {
  const EditProfileLoading();
}

class BottomLoadingState extends EditProfileState {
  const BottomLoadingState();
}

class ProfileImagePickedState extends EditProfileState {
  const ProfileImagePickedState();
}

class FetchProfileSuccess extends EditProfileState {
  final UserModel user;
  const FetchProfileSuccess(this.user);
  @override
  List<Object?> get props => [user];
}

class EditProfileSuccess extends EditProfileState {
  final UserModel user;
  const EditProfileSuccess(this.user);
  @override
  List<Object?> get props => [user];
}

class EditProfileFailure extends EditProfileState {
  final String error;
  const EditProfileFailure(this.error);
  @override
  List<Object?> get props => [error];
}

class FetchProfileFailure extends EditProfileState {
  final String error;
  const FetchProfileFailure(this.error);
  @override
  List<Object?> get props => [error];
}
