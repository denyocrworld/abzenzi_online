import 'package:shared_preferences/shared_preferences.dart';

import '../auth_service/auth_service.dart';

class LocalDataService {
  static late final SharedPreferences prefs;
  static init() async {
    prefs = await SharedPreferences.getInstance();
  }

  static saveToken(String token) async {
    await prefs.setString('token', token);
  }

  static getToken() async {
    AuthService.localStorageToken = await prefs.getString('token') ?? "";
  }
}
