import 'package:json_annotation/json_annotation.dart';

part 'my_feedback_model.g.dart';

@JsonSerializable()
class MyFeedbackModel {
  final int id;
  final int scan;
  final String? note;
  final String status;
  @JsonKey(name: 'scan_result')
  final String? scanResult;
  @JsonKey(name: 'created_at')
  final String createdAt;

  MyFeedbackModel({
    required this.id,
    required this.scan,
    this.note,
    required this.status,
    this.scanResult,
    required this.createdAt,
  });

  factory MyFeedbackModel.fromJson(Map<String, dynamic> json) =>
      _$MyFeedbackModelFromJson(json);
}
