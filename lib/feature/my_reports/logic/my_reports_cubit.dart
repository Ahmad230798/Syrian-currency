import 'package:flutter_bloc/flutter_bloc.dart';
import '../repo/my_reports_repo.dart';
import 'my_reports_state.dart';

class MyReportsCubit extends Cubit<MyReportsState> {
  final MyReportsRepo _repo;
  MyReportsCubit(this._repo) : super(MyReportsInitial());

  Future<void> fetchMyReports() async {
    emit(MyReportsLoading());
    final result = await _repo.getMyReports();
    result.fold(
      (failure) => emit(MyReportsError(failure.errorMessage)),
      (reports) => emit(MyReportsSuccess(reports)),
    );
  }
}
