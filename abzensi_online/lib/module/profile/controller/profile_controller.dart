import 'package:flutter/material.dart';
import 'package:hyper_ui/core.dart';
import 'package:hyper_ui/service/auth_service/auth_service.dart';
import 'package:hyper_ui/service/user_service/user_service.dart';
import '../../../model/user/user.dart';

class ProfileController extends State<ProfileView> {
  static late ProfileController instance;
  late ProfileView view;

  @override
  void initState() {
    instance = this;
    getUser();
    super.initState();
  }

  @override
  void dispose() => super.dispose();

  @override
  Widget build(BuildContext context) => widget.build(context, this);

  doLogout() async {
    showLoading();
    await AuthService().logout();
    hideLoading();

    Get.offAll(LoginView());
  }

  User? user;
  getUser() async {
    user = await UserService().getUser();
    photo = user?.photo;
    name = user?.name;
    setState(() {});
  }

  String? photo;
  String? name;
  updateUser() async {
    showLoading();
    await UserService().updateUser(
      name: name,
      photo: photo,
    );
    await getUser();
    hideLoading();

    snackbarInfo(
      message: "Your data has been updated!",
    );
  }
}
