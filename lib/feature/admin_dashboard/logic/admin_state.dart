import '../models/admin_models.dart';

abstract class AdminState {}

class AdminInitial extends AdminState {}

class AdminLoading extends AdminState {}

class AdminSuccess extends AdminState {
  final List<AdminUserModel> users;
  final List<AdminFeedbackModel> feedbacks;
  final AdminStatsModel stats;
  final List<AdminScanModel> scans;
  final List<AdminPolicyModel> policies;

  AdminSuccess({
    required this.users,
    required this.feedbacks,
    required this.stats,
    required this.scans,
    required this.policies,
  });
}

class AdminError extends AdminState {
  final String message;
  AdminError(this.message);
}

// حالة منفصلة لتحديث الـ Role لكي نعرض دائرة تحميل صغيرة فوق الزر
class AdminChangeRoleLoading extends AdminState {}

class AdminChangeRoleSuccess extends AdminState {
  final String message;
  AdminChangeRoleSuccess(this.message);
}

class AdminPolicyUpdateSuccess extends AdminState {
  final String message;
  AdminPolicyUpdateSuccess(this.message);
}

class AdminDeleteUserSuccess extends AdminState {
  final String message;
  AdminDeleteUserSuccess(this.message);
}
