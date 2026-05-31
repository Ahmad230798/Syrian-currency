import 'package:syrian_currency/feature/camera_scan/model/scanner_response_model.dart';

abstract class ExpertFeedState {}

class ExpertFeedInitial extends ExpertFeedState {}

class ExpertFeedLoading extends ExpertFeedState {}

class ExpertFeedSuccess extends ExpertFeedState {
  final List<ScanDataModel> scans;
  ExpertFeedSuccess(this.scans);
}

class ExpertFeedError extends ExpertFeedState {
  final String error;
  ExpertFeedError(this.error);
}
