import 'package:json_annotation/json_annotation.dart';

part 'admin_models.g.dart';

// 1. نموذج المستخدم في لوحة التحكم (يحتوي على scan_count)
@JsonSerializable()
class AdminUserModel {
  final int id;
  final String email;
  @JsonKey(name: 'full_name')
  final String fullName;
  final String role;
  final String? avatar;
  @JsonKey(name: 'date_joined')
  final String dateJoined;
  @JsonKey(name: 'scan_count')
  final int scanCount;

  AdminUserModel({
    required this.id,
    required this.email,
    required this.fullName,
    required this.role,
    this.avatar,
    required this.dateJoined,
    required this.scanCount,
  });

  factory AdminUserModel.fromJson(Map<String, dynamic> json) =>
      _$AdminUserModelFromJson(json);
}

// 2. نموذج تقارير الخبراء (Feedback)
@JsonSerializable()
class AdminFeedbackModel {
  final int id;
  final int scan;
  final String? note;
  final String status;
  @JsonKey(name: 'expert_name')
  final String expertName;
  @JsonKey(name: 'scan_result')
  final String scanResult;
  @JsonKey(name: 'created_at')
  final String createdAt;

  AdminFeedbackModel({
    required this.id,
    required this.scan,
    this.note,
    required this.status,
    required this.expertName,
    required this.scanResult,
    required this.createdAt,
  });

  factory AdminFeedbackModel.fromJson(Map<String, dynamic> json) =>
      _$AdminFeedbackModelFromJson(json);
}

// 3. نموذج إحصائيات النظام (Stats)
class AdminStatsModel {
  final int totalScans;
  final int counterfeits;
  final int totalUsers;
  final int activeExperts;

  AdminStatsModel({
    required this.totalScans,
    required this.counterfeits,
    required this.totalUsers,
    required this.activeExperts,
  });

  factory AdminStatsModel.fromJson(Map<String, dynamic> json) {
    // كود ذكي للبحث عن الداتا سواء كانت مقسمة أو مسطحة وبأسماء مختلفة
    final overall = json['overall'] ?? json;
    final users = json['users'] ?? json;

    return AdminStatsModel(
      totalScans: int.tryParse(overall['total_scans']?.toString() ?? '0') ?? 0,
      counterfeits:
          int.tryParse(overall['counterfeits']?.toString() ?? '0') ?? 0,
      totalUsers: int.tryParse(users['total_users']?.toString() ?? '0') ?? 0,
      activeExperts:
          int.tryParse(users['active_experts']?.toString() ?? '0') ?? 0,
    );
  }
}

// 4. نموذج تاريخ الفحوصات للإدمن
@JsonSerializable()
class AdminScanModel {
  final int id;
  final String result;
  final String status;
  @JsonKey(name: 'mse_score')
  final double? mseScore;
  final double? confidence;
  @JsonKey(name: 'created_at')
  final String createdAt;

  AdminScanModel({
    required this.id,
    required this.result,
    required this.status,
    this.mseScore,
    this.confidence,
    required this.createdAt,
  });

  factory AdminScanModel.fromJson(Map<String, dynamic> json) =>
      _$AdminScanModelFromJson(json);
}

// 5. نموذج السياسات
@JsonSerializable()
class AdminPolicyModel {
  final String role;
  @JsonKey(name: 'daily_scan_limit')
  final int dailyScanLimit;
  @JsonKey(name: 'history_days')
  final int historyDays;
  @JsonKey(name: 'can_view_heatmap')
  final bool canViewHeatmap;
  @JsonKey(name: 'can_view_mse')
  final bool canViewMse;
  @JsonKey(name: 'can_export_report')
  final bool canExportReport;
  @JsonKey(name: 'can_give_feedback')
  final bool canGiveFeedback;

  AdminPolicyModel({
    required this.role,
    required this.dailyScanLimit,
    required this.historyDays,
    required this.canViewHeatmap,
    required this.canViewMse,
    required this.canExportReport,
    required this.canGiveFeedback,
  });

  factory AdminPolicyModel.fromJson(Map<String, dynamic> json) =>
      _$AdminPolicyModelFromJson(json);
}
