import 'package:equatable/equatable.dart';
import 'package:syrian_currency/core/models/user_model.dart';

abstract class SettingState extends Equatable {
  const SettingState();
  @override
  List<Object> get props => [];
}

class SettingInitState extends SettingState {
  const SettingInitState();
}

class SettingLoadingState extends SettingState {
  const SettingLoadingState();
}

class SettingSuccessState extends SettingState {
  final UserModel user;
  const SettingSuccessState(this.user);
  @override
  List<Object> get props => [user];
}

class SettingFailureState extends SettingState {
  final String errorMessage;
  const SettingFailureState(this.errorMessage);
  @override
  List<Object> get props => [errorMessage];
}
