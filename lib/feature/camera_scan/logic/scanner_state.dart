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
  final bool isExpert; // 👈 أضفنا هذا المتغير

  // جعلنا القيمة الافتراضية false للحماية
  const ScannerSuccess(this.response, {this.isExpert = false});

  @override
  List<Object?> get props => [response, isExpert];
}

class ScannerFailure extends ScannerState {
  final String errorMessage;
  const ScannerFailure(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
