
import '../../core.dart';

class AuthService {
  // static Map currentUser = {};
  static User? currentUser;
  static String? localStorageToken;

  static String? get token {
    if (localStorageToken != null) return localStorageToken;
    return currentUser?.token;
  }

  static int get id => currentUser!.id!;

  login({
    required String email,
    required String password,
  }) async {
    var response = await Dio().post(
      "${Env.baseUrl}/api/login",
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
      currentUser = User.fromJson(obj["data"]);
    }
    return obj;
  }

  logout() async {
    await Dio().post(
      "${Env.baseUrl}/api/logout",
      options: Options(
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${AuthService.token}",
        },
      ),
    );
  }
}
