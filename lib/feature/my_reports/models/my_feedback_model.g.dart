// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_feedback_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyFeedbackModel _$MyFeedbackModelFromJson(Map<String, dynamic> json) =>
    MyFeedbackModel(
      id: (json['id'] as num).toInt(),
      scan: (json['scan'] as num).toInt(),
      note: json['note'] as String?,
      status: json['status'] as String,
      scanResult: json['scan_result'] as String?,
      createdAt: json['created_at'] as String,
    );

Map<String, dynamic> _$MyFeedbackModelToJson(MyFeedbackModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'scan': instance.scan,
      'note': instance.note,
      'status': instance.status,
      'scan_result': instance.scanResult,
      'created_at': instance.createdAt,
    };
