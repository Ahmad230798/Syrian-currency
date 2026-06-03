import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  SharedPreferences? _pref;

  Future<SharedPreferences> get _prefs async {
    return _pref ??= await SharedPreferences.getInstance();
  }

  // الثوابت (المفاتيح)
  static const String accessTokenKey = 'access_token';
  static const String refreshTokenKey = 'refresh_token';
  static const String deviceIdKey = 'device_id';
  static const String roleKey = 'user_role';

  // =====================================
  // 1. إدارة التوكنز
  // =====================================
  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    final prefs = await _prefs;
    await prefs.setString(accessTokenKey, accessToken);
    await prefs.setString(refreshTokenKey, refreshToken);
  }

  Future<String?> getAccessToken() async {
    final prefs = await _prefs;
    return prefs.getString(accessTokenKey);
  }

  Future<String?> getRefreshToken() async {
    final prefs = await _prefs;
    return prefs.getString(refreshTokenKey);
  }

  Future<void> clearTokens() async {
    final prefs = await _prefs;
    await prefs.remove(accessTokenKey);
    await prefs.remove(refreshTokenKey);
    await prefs.remove(roleKey); // مسح الصلاحية عند تسجيل الخروج
  }

  // =====================================
  // 2. إدارة معرف الجهاز
  // =====================================
  Future<String> getDeviceId() async {
    final prefs = await _prefs;
    String? deviceId = prefs.getString(deviceIdKey);

    if (deviceId == null) {
      deviceId = 'device_${DateTime.now().millisecondsSinceEpoch}';
      await prefs.setString(deviceIdKey, deviceId);
    }
    return deviceId;
  }

  // =====================================
  // 3. إدارة الصلاحيات
  // =====================================
  Future<void> saveUserRole(String role) async {
    final prefs = await _prefs;
    await prefs.setString(roleKey, role);
  }

  Future<String> getUserRole() async {
    final prefs = await _prefs;
    return prefs.getString(roleKey) ?? 'user';
  }
}
