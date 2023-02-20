import 'package:hive/hive.dart';

late Box mainStorage;

class SessionManager {
  static bool isLogin = mainStorage.get("isAdminLoggedIn") ?? false;

  static saveLogin() {
    mainStorage.put("isAdminLoggedIn", true);
  }
}
