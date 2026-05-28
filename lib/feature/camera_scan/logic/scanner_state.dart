import 'package:equatable/equatable.dart';
import 'package:syrian_currency/feature/camera_scan/model/scanner_response_model.dart';

abstract class ScannerState extends Equatable {
  const ScannerState();

  @override
  List<Object?> get props => [];
}

class ScannerInitial extends ScannerState {}

class ScannerLoading extends ScannerState {}

class ScannerSuccess extends ScannerState {
  final ScannerResponseModel response;

  const ScannerSuccess(this.response);

  @override
  List<Object?> get props => [response];
}

class ScannerFailure extends ScannerState {
  final String errorMessage;

  const ScannerFailure(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
