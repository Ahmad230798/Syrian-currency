import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  SharedPreferences? _pref;
  Future<SharedPreferences> get _prefs async {
    return _pref ??= await SharedPreferences.getInstance();
  }

  static const String accessTokenKey = 'access_token';
  static const String refreshTokenKey = 'refresh_token';

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
  }

  static const String deviceIdKey = 'device_id';

  // توليد مُعرّف عشوائي للجهاز إذا لم يكن موجوداً
  Future<String> getDeviceId() async {
    final prefs = await _prefs;
    String? deviceId = prefs.getString(deviceIdKey);

    if (deviceId == null) {
      // توليد مُعرّف يعتمد على الوقت كحل بسيط وسريع
      deviceId = 'device_${DateTime.now().millisecondsSinceEpoch}';
      await prefs.setString(deviceIdKey, deviceId);
    }
    return deviceId;
  }

  // حفظ صلاحية المستخدم
  Future<void> saveUserRole(String role) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_role', role);
  }

  // جلب صلاحية المستخدم
  Future<String> getUserRole() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('user_role') ?? 'user'; // الافتراضي user
  }
}
