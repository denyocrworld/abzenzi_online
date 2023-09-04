import '../../core.dart';

class AuthService {
  static Map currentUser = {};
  static String get token => currentUser["token"];

  login({
    required String email,
    required String password,
  }) async {
    var response = await Dio().post(
      "http://127.0.0.1:8000/api/login",
      options: Options(
        headers: {
          "Content-Type": "application/json",
        },
      ),
      data: {
        "email": email,
        "password": password,
      },
    );
    print(response);
    Map obj = response.data;

    if (obj["success"] == true) {
      currentUser = obj["data"];
    }
    return obj;
  }

  logout() async {
    await Dio().post(
      "http://127.0.0.1:8000/api/logout",
      options: Options(
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${AuthService.token}",
        },
      ),
    );
  }
}
