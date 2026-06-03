class ApiConstants {
  static const String baseUrl = "http://10.0.2.2:8000";
  static const String apiBaseUrl = "http://10.0.2.2:8000/api/";

  // Auth & Profile
  static const String login = "auth/login/";
  static const String register = "auth/register/";
  static const String userProfile = "auth/profile/";

  // Scanner
  static const String scannerScan = "scanner/scan/";
  static const String scanHistory = "scanner/history/";

  // ADMIN ENDPOINTS
  static const String adminUsers = "auth/admin/users/";
  static const String adminStats = "scanner/admin/stats/";
  static const String adminFeedback = "policies/feedback/all/";
  static const String adminAllHistory = "scanner/admin/history/";
  static const String adminAllPolicies = "policies/all/";
  static const String adminUpdatePolicy = "policies/admin/role/";

  // EXPERT ENDPOINTS
  static const String createFeedback = "policies/feedback/";
  static const String expertFeed = "scanner/expert/feed/";
  static const String myFeedbacks = "policies/feedback/mine/";
}
