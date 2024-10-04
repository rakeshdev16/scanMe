import 'package:scan_me_plus/export.dart';

class PreferenceManager {
  static const prefKeyIsFirstLaunch = 'pref_key_is_first_launch';
  static const prefKeyUserToken = 'pref_key_user_token';
  static const prefKeyUser = 'pref_key_user';

  static late SharedPreferences _prefs;

  PreferenceManager._();

  static Future<SharedPreferences> _getInstance() {
    return SharedPreferences.getInstance();
  }

  static Future<bool> init() async {
    _prefs = await _getInstance();
    return Future.value(true);
  }

  static void save2Pref(String key, dynamic value) {
    if (value is bool) {
      _prefs.setBool(key, value);
    } else if (value is int) {
      _prefs.setInt(key, value);
    } else if (value is double) {
      _prefs.setDouble(key, value);
    } else if (value is String) {
      _prefs.setString(key, value);
    } else {}
  }

  static Object? getPref(String key) {
    return _prefs.get(key);
  }

  static String get userToken => _prefs.getString(prefKeyUserToken) ?? '';
  static set userToken(String? token) {
    _prefs.setString(prefKeyUserToken, token ?? '');
  }

  static User? get user {
    String? user = _prefs.getString(prefKeyUser);
    if (user != null) {
      return User.fromJson(jsonDecode(user));
    } else {
      return null;
    }
  }

  static set user(User? user) {
    if (user != null) {
      _prefs.setString(prefKeyUser, jsonEncode(user.toJson()));
    } else {
      _prefs.remove(prefKeyUser);
    }
  }

  static bool get isFirstLaunch =>
      (getPref(prefKeyIsFirstLaunch) ?? false) as bool;

  static set isFirstLaunch(bool isFirstLaunch) {
    _prefs.setBool(prefKeyIsFirstLaunch, isFirstLaunch);
  }

  static void clean() async {
    await _prefs.clear();
  }

  static void logoutUser() {
    _prefs.remove(prefKeyUserToken);
    _prefs.remove(prefKeyUser);
  }

  static void removeUserData() {
    _prefs.remove(prefKeyUser);
  }
}
