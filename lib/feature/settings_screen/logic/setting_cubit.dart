import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syrian_currency/feature/settings_screen/logic/setting_state.dart';
import 'package:syrian_currency/feature/settings_screen/repo/setting_repo.dart';

class SettingCubit extends Cubit<SettingState> {
  final SettingRepo repo;
  SettingCubit({required this.repo}) : super(const SettingInitState());

  Future<void> getUsernfo() async {
    emit(SettingLoadingState());
    final result = await repo.getUserInfo();
    result.fold((failure) => emit(SettingFailureState(failure.errorMessage)), (
      user,
    ) {
      emit(SettingSuccessState(user));
    });
  }
}
