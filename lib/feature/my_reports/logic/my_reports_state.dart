import '../models/my_feedback_model.dart';

abstract class MyReportsState {}

class MyReportsInitial extends MyReportsState {}

class MyReportsLoading extends MyReportsState {}

class MyReportsSuccess extends MyReportsState {
  final List<MyFeedbackModel> reports;
  MyReportsSuccess(this.reports);
}

class MyReportsError extends MyReportsState {
  final String error;
  MyReportsError(this.error);
}
