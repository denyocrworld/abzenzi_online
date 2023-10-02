import 'package:flutter/material.dart';
import 'package:hyper_ui/core.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationDisabledController extends State<LocationDisabledView> {
  static late LocationDisabledController instance;
  late LocationDisabledView view;

  @override
  void initState() {
    instance = this;
    super.initState();
  }

  @override
  void dispose() => super.dispose();

  @override
  Widget build(BuildContext context) => widget.build(context, this);

  openMyAppSettings() async {
    await openAppSettings();
  }

  openLoginView() async {
    var response = await LocationService.getCurrentLocation();
    if (response.position != null) {
      Get.offAll(LoginView());
    }
  }
}
