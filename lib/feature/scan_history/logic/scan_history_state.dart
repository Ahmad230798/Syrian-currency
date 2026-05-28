import 'package:syrian_currency/feature/camera_scan/model/scanner_response_model.dart';

abstract class ScanHistoryState {}

class ScanHistoryInitial extends ScanHistoryState {}

class ScanHistoryLoading extends ScanHistoryState {}

class ScanHistorySuccess extends ScanHistoryState {
  final List<ScanDataModel> historyList;
  ScanHistorySuccess(this.historyList);
}

class ScanHistoryFailure extends ScanHistoryState {
  final String errorMessage;
  ScanHistoryFailure(this.errorMessage);
}
