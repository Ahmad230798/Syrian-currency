import 'package:syrian_currency/core/networking/api_constants.dart';
import 'package:syrian_currency/core/networking/api_service.dart';
import 'package:syrian_currency/feature/admin_dashboard/models/admin_models.dart';

class AdminRepo {
  final ApiServices _apiServices;

  AdminRepo(this._apiServices);

  // جلب كل المستخدمين
  Future<List<AdminUserModel>> getAllUsers() async {
    final response = await _apiServices.getData(url: ApiConstants.adminUsers);
    // التعامل مع الاستجابة سواء كانت داخل 'data' أو مصفوفة مباشرة
    List data = response is Map ? (response['data'] ?? response) : response;
    return data.map((json) => AdminUserModel.fromJson(json)).toList();
  }

  // تغيير دور المستخدم
  Future<void> changeUserRole(int userId, String newRole) async {
    await _apiServices.putData(
      // نستخدم PUT (أو PATCH) مع إضافة Slash في النهاية
      url: "${ApiConstants.adminUsers}$userId/change-role/",
      body: {"role": newRole},
    );
  }

  // جلب إحصائيات النظام
  Future<AdminStatsModel> getAdminStats() async {
    final response = await _apiServices.getData(url: ApiConstants.adminStats);
    final data = response['data'] ?? response;
    return AdminStatsModel.fromJson(data);
  }

  // جلب كل تقارير التقييم من الخبراء
  Future<List<AdminFeedbackModel>> getAllFeedback() async {
    final response = await _apiServices.getData(
      url: ApiConstants.adminFeedback,
    );
    List data = response is Map ? (response['data'] ?? response) : response;
    return data.map((json) => AdminFeedbackModel.fromJson(json)).toList();
  }

  // جلب كل فحوصات النظام
  Future<List<AdminScanModel>> getAllScans() async {
    final response = await _apiServices.getData(
      url: ApiConstants.adminAllHistory,
    );
    List data = response is Map ? (response['data'] ?? response) : response;
    return data.map((json) => AdminScanModel.fromJson(json)).toList();
  }

  // جلب كل السياسات
  Future<List<AdminPolicyModel>> getAllPolicies() async {
    final response = await _apiServices.getData(
      url: ApiConstants.adminAllPolicies,
    );
    List data = response is Map ? (response['data'] ?? response) : response;
    return data.map((json) => AdminPolicyModel.fromJson(json)).toList();
  }

  // تحديث سياسة معينة (Toggle)
  Future<void> updatePolicy(
    String role,
    Map<String, dynamic> updatedData,
  ) async {
    await _apiServices.putData(
      url: "${ApiConstants.adminUpdatePolicy}$role/",
      body: updatedData,
    );
  }

  // دالة حذف حساب المستخدم
  Future<void> deleteUser(int userId) async {
    // نفترض أن لديك دالة deleteData في ملف api_service.dart
    // إذا لم تكن موجودة يمكنك استخدام dio.delete مباشرة
    await _apiServices.deleteData(
      url: "${ApiConstants.adminUsers}$userId/delete/",
    );
  }
}
