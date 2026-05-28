import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syrian_currency/feature/scan_history/logic/scan_history_state.dart';
import 'package:syrian_currency/feature/scan_history/repo/scan_history_repo.dart';

class ScanHistoryCubit extends Cubit<ScanHistoryState> {
  final ScanHistoryRepo scanHistoryRepo;

  ScanHistoryCubit(this.scanHistoryRepo) : super(ScanHistoryInitial());

  Future<void> fetchHistory() async {
    emit(ScanHistoryLoading());

    final result = await scanHistoryRepo.getScanHistory();

    result.fold(
      (failure) => emit(ScanHistoryFailure(failure.errorMessage)),
      (success) => emit(ScanHistorySuccess(success)),
    );
  }
}
