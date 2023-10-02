import 'package:shared_preferences/shared_preferences.dart';

import '../auth_service/auth_service.dart';

class LocalDataService {
  static SharedPreferences? prefs;
  static init() async {
    if (prefs == null) {
      prefs = await SharedPreferences.getInstance();
    }
  }

  static saveToken(String token) async {
    await prefs!.setString('token', token);
  }

  static getToken() async {
    AuthService.localStorageToken = await prefs!.getString('token') ?? "";
  }
}
