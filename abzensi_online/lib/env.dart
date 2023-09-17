import 'package:hyper_ui/service/auth_service/auth_service.dart';

import 'core.dart';

class Env {
  static String baseUrl = "http://192.168.1.7:8000";

  static Options get options {
    return Options(
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${AuthService.token}",
      },
    );
  }
}
