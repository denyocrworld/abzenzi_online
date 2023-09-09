import 'package:dio/dio.dart';
import 'package:hyper_ui/service/auth_service/auth_service.dart';

import '../../env.dart';
import '../../model/user/user.dart';

class UserService {
  Future<User> getUser() async {
    var id = AuthService.currentUser!.id;
    var response = await Dio().get(
      "${Env.baseUrl}/api/users/$id",
      options: Options(
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${AuthService.token}",
        },
      ),
    );
    Map obj = response.data;
    return User.fromJson(obj["data"]);
  }

  Future updateUser({
    String? name,
    String? photo,
  }) async {
    var id = AuthService.currentUser!.id;
    await Dio().put(
      "${Env.baseUrl}/api/users/$id",
      options: Options(
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${AuthService.token}",
        },
      ),
      data: {
        "name": name,
        "photo": photo,
      },
    );
  }
}
