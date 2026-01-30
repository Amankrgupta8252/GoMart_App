import 'package:get_storage/get_storage.dart';

class LocalStorage {
  static final _storage = GetStorage();

  static const String keyIsLoggedIn = 'is_logged_in';
  static const String keyLoginMethod = 'login_method';
  static const String keyUserEmail = 'user_email';

  static void saveSession({required String email, required String method}) {
    _storage.write(keyIsLoggedIn, true);
    _storage.write(keyUserEmail, email);
    _storage.write(keyLoginMethod, method);
  }

  static bool isLoggedIn() => _storage.read(keyIsLoggedIn) ?? false;

  static String getMethod() => _storage.read(keyLoginMethod) ?? '';

  static void clear() => _storage.erase();

  // local_storage.dart mein add karein
  // Optimized methods
  static bool isFirstTime() {
    return _storage.read('isFirstTime') ?? true;
  }

  static void setFirstTimeFalse() {
    _storage.write('isFirstTime', false);
  }
}
