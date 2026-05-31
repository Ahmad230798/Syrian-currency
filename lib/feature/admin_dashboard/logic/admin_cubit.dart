// ignore_for_file: avoid_print

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syrian_currency/core/networking/api_error_handler.dart';
import '../repo/admin_repo.dart';
import 'admin_state.dart';

class AdminCubit extends Cubit<AdminState> {
  final AdminRepo _adminRepo;
  AdminCubit(this._adminRepo) : super(AdminInitial());

  Future<void> fetchAllAdminData() async {
    emit(AdminLoading());
    try {
      print("⏳ جاري جلب المستخدمين...");
      final usersResult = await _adminRepo.getAllUsers();

      print("⏳ جاري جلب التقارير...");
      final feedbackResult = await _adminRepo.getAllFeedback();

      print("⏳ جاري جلب الإحصائيات...");
      final statsResult = await _adminRepo.getAdminStats();

      print("⏳ جاري جلب سجل الفحوصات...");
      final scansResult = await _adminRepo.getAllScans();

      print("⏳ جاري جلب السياسات...");
      final policiesResult = await _adminRepo.getAllPolicies();

      emit(
        AdminSuccess(
          users: usersResult,
          feedbacks: feedbackResult,
          stats: statsResult,
          scans: scansResult,
          policies: policiesResult,
        ),
      );
      print("✅ تم جلب جميع البيانات بنجاح!");
    } catch (e, stacktrace) {
      print("🔴 حدث خطأ أثناء جلب البيانات: $e");
      print("🔍 تفاصيل الخطأ (Stacktrace): \n$stacktrace");

      if (e is ServerFailure) {
        emit(AdminError(e.errorMessage));
      } else {
        emit(AdminError(e.toString()));
      }
    }
  }

  Future<void> changeRole(int userId, String newRole) async {
    emit(AdminChangeRoleLoading());
    try {
      print("🔵 جاري إرسال طلب التعديل للمستخدم $userId بصلاحية $newRole");
      // تأكد أن الحروف صغيرة (user, expert, admin)
      await _adminRepo.changeUserRole(userId, newRole.toLowerCase());
      emit(AdminChangeRoleSuccess("تم تحديث صلاحية المستخدم بنجاح"));
      await fetchAllAdminData();
    } catch (e) {
      print(
        "🔴 خطأ أثناء تغيير الصلاحية: $e",
      ); // هذا سيظهر لك الخطأ الفعلي في الكونسول
      if (e is ServerFailure) {
        emit(AdminError(e.errorMessage));
      } else {
        emit(AdminError(e.toString()));
      }
      await fetchAllAdminData(); // إعادة الواجهة لحالة Success في حال الفشل
    }
  }

  // دالة تحديث السياسات (Toggles)
  Future<void> togglePolicy(
    String role,
    String fieldName,
    bool newValue,
  ) async {
    try {
      await _adminRepo.updatePolicy(role, {fieldName: newValue});
      emit(AdminPolicyUpdateSuccess("تم تحديث السياسة بنجاح"));
      await fetchAllAdminData();
    } catch (e) {
      if (e is ServerFailure) {
        emit(AdminError(e.errorMessage));
      } else {
        emit(AdminError(e.toString()));
      }
      await fetchAllAdminData();
    }
  }

  // دالة حذف المستخدم
  Future<void> deleteUser(int userId) async {
    try {
      print("🔵 جاري إرسال طلب حذف للمستخدم $userId");
      await _adminRepo.deleteUser(userId);
      emit(AdminDeleteUserSuccess("تم حذف المستخدم نهائياً من النظام."));
      await fetchAllAdminData(); // تحديث الجدول بعد الحذف
    } catch (e) {
      print("🔴 خطأ أثناء حذف المستخدم: $e");
      if (e is ServerFailure) {
        emit(AdminError(e.errorMessage));
      } else {
        emit(AdminError(e.toString()));
      }
      await fetchAllAdminData();
    }
  }
}
