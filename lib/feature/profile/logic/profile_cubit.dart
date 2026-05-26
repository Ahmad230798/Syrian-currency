import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:syrian_currency/feature/profile/logic/profile_state.dart';
import 'package:syrian_currency/feature/profile/repo/profile_repo.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepo repo;
  ProfileCubit({required this.repo}) : super(ProfileInit());
  Future<void> getProfileInfo() async {
    emit(ProfileLoading());
    final result = await repo.getUserProfile();
    result.fold((failure) => emit(ProfileFailure(failure.errorMessage)), (
      user,
    ) {
      emit(ProfileSuccess(user));
    });
  }
}
