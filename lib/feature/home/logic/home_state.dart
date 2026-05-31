part of 'home_cubit.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

final class HomeInitial extends HomeState {
  const HomeInitial();
}

final class HomeLoading extends HomeState {
  const HomeLoading();
}

final class ScanLoading extends HomeState {
  const ScanLoading();
}

final class ImagePickedState extends HomeState {
  const ImagePickedState();
}

final class ImageFailureState extends HomeState {
  final String errorMessage;
  const ImageFailureState({required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}

final class ScannerFailure extends HomeState {
  final String errorMessage;
  const ScannerFailure(this.errorMessage);
  @override
  List<Object> get props => [errorMessage];
}

final class HomeSuccess extends HomeState {
  final List<ScanDataModel> historyList;
  const HomeSuccess(this.historyList);
  @override
  List<Object> get props => [historyList];
}

class ScannerSuccess extends HomeState {
  final ScannerResponseModel response;

  const ScannerSuccess(this.response);
  @override
  List<Object> get props => [response];
}

final class HomeFailure extends HomeState {
  final String errorMessage;
  const HomeFailure(this.errorMessage);
  @override
  List<Object> get props => [errorMessage];
}
