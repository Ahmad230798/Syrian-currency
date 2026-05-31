import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../repo/feedback_repo.dart';
import 'feedback_state.dart';

class FeedbackCubit extends Cubit<FeedbackState> {
  final FeedbackRepo _feedbackRepo;
  final TextEditingController noteController = TextEditingController();

  FeedbackCubit(this._feedbackRepo) : super(FeedbackInitial());

  Future<void> submitReport(int scanId) async {
    if (noteController.text.trim().isEmpty) {
      emit(FeedbackError("Please write a reason for rejecting the AI result."));
      return;
    }

    emit(FeedbackLoading());
    final result = await _feedbackRepo.submitFeedback(
      scanId: scanId,
      note: noteController.text.trim(),
    );

    result.fold((failure) => emit(FeedbackError(failure.errorMessage)), (
      success,
    ) {
      emit(FeedbackSuccess(success));
      noteController.clear(); // تنظيف الحقل بعد النجاح
    });
  }

  @override
  Future<void> close() {
    noteController.dispose();
    return super.close();
  }
}
