import 'package:flutter_bloc/flutter_bloc.dart';
import '../repo/expert_feed_repo.dart';
import 'expert_feed_state.dart';

class ExpertFeedCubit extends Cubit<ExpertFeedState> {
  final ExpertFeedRepo _repo;
  ExpertFeedCubit(this._repo) : super(ExpertFeedInitial());

  Future<void> fetchFeed() async {
    emit(ExpertFeedLoading());
    final result = await _repo.getCommunityFeed();
    result.fold(
      (failure) => emit(ExpertFeedError(failure.errorMessage)),
      (scans) => emit(ExpertFeedSuccess(scans)),
    );
  }
}
