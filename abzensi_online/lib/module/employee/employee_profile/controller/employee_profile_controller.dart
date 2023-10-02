import 'package:flutter/material.dart';
import 'package:hyper_ui/core.dart';

class EmployeeProfileController extends State<EmployeeProfileView> {
  static late EmployeeProfileController instance;
  late EmployeeProfileView view;

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
