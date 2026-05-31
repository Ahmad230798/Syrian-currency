// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdminUserModel _$AdminUserModelFromJson(Map<String, dynamic> json) =>
    AdminUserModel(
      id: (json['id'] as num).toInt(),
      email: json['email'] as String,
      fullName: json['full_name'] as String,
      role: json['role'] as String,
      avatar: json['avatar'] as String?,
      dateJoined: json['date_joined'] as String,
      scanCount: (json['scan_count'] as num).toInt(),
    );

Map<String, dynamic> _$AdminUserModelToJson(AdminUserModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'full_name': instance.fullName,
      'role': instance.role,
      'avatar': instance.avatar,
      'date_joined': instance.dateJoined,
      'scan_count': instance.scanCount,
    };

AdminFeedbackModel _$AdminFeedbackModelFromJson(Map<String, dynamic> json) =>
    AdminFeedbackModel(
      id: (json['id'] as num).toInt(),
      scan: (json['scan'] as num).toInt(),
      note: json['note'] as String?,
      status: json['status'] as String,
      expertName: json['expert_name'] as String,
      scanResult: json['scan_result'] as String,
      createdAt: json['created_at'] as String,
    );

Map<String, dynamic> _$AdminFeedbackModelToJson(AdminFeedbackModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'scan': instance.scan,
      'note': instance.note,
      'status': instance.status,
      'expert_name': instance.expertName,
      'scan_result': instance.scanResult,
      'created_at': instance.createdAt,
    };

AdminScanModel _$AdminScanModelFromJson(Map<String, dynamic> json) =>
    AdminScanModel(
      id: (json['id'] as num).toInt(),
      result: json['result'] as String,
      status: json['status'] as String,
      mseScore: (json['mse_score'] as num?)?.toDouble(),
      confidence: (json['confidence'] as num?)?.toDouble(),
      createdAt: json['created_at'] as String,
    );

Map<String, dynamic> _$AdminScanModelToJson(AdminScanModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'result': instance.result,
      'status': instance.status,
      'mse_score': instance.mseScore,
      'confidence': instance.confidence,
      'created_at': instance.createdAt,
    };

AdminPolicyModel _$AdminPolicyModelFromJson(Map<String, dynamic> json) =>
    AdminPolicyModel(
      role: json['role'] as String,
      dailyScanLimit: (json['daily_scan_limit'] as num).toInt(),
      historyDays: (json['history_days'] as num).toInt(),
      canViewHeatmap: json['can_view_heatmap'] as bool,
      canViewMse: json['can_view_mse'] as bool,
      canExportReport: json['can_export_report'] as bool,
      canGiveFeedback: json['can_give_feedback'] as bool,
    );

Map<String, dynamic> _$AdminPolicyModelToJson(AdminPolicyModel instance) =>
    <String, dynamic>{
      'role': instance.role,
      'daily_scan_limit': instance.dailyScanLimit,
      'history_days': instance.historyDays,
      'can_view_heatmap': instance.canViewHeatmap,
      'can_view_mse': instance.canViewMse,
      'can_export_report': instance.canExportReport,
      'can_give_feedback': instance.canGiveFeedback,
    };
