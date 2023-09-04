import 'package:flutter/material.dart';
import 'package:hyper_ui/core.dart';
import 'package:hyper_ui/service/auth_service/auth_service.dart';
import '../view/login_view.dart';

class LoginController extends State<LoginView> {
  static late LoginController instance;
  late LoginView view;

  @override
  void initState() {
    instance = this;
    super.initState();
  }

  @override
  void dispose() => super.dispose();

  @override
  Widget build(BuildContext context) => widget.build(context, this);

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String email = "";
  String password = "";
  bool loading = false;

  doLogin() async {
    bool isValid = formKey.currentState!.validate();
    if (!isValid) {
      return;
    }

    showLoading();

    var obj = await AuthService().login(
      email: email,
      password: password,
    );
    bool isSuccess = obj["success"] == true;

    hideLoading();

    if (!isSuccess) {
      String message = obj["data"]["message"];
      showInfoDialog(message);
      return;
    }

    Get.offAll(MainNavigationView());
  }
}
