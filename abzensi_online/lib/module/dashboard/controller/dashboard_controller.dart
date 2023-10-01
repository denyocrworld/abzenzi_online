import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hyper_ui/core.dart';
import 'package:hyper_ui/service/device_service/device_service.dart';
import 'package:hyper_ui/service/location_service/location_service.dart';
import '../view/dashboard_view.dart';

class DashboardController extends State<DashboardView> {
  static late DashboardController instance;
  late DashboardView view;

  @override
  void initState() {
    instance = this;
    initData();
    super.initState();
  }

  @override
  void dispose() => super.dispose();

  @override
  Widget build(BuildContext context) => widget.build(context, this);

  String deviceModel = "";
  Position? position;

  initData() async {
    await Future.wait([
      getCheckInTodayStatus(),
      getCheckOutTodayStatus(),
    ]);

    deviceModel = await DeviceService.getDeviceModel();
    final response = await LocationService.getCurrentLocation();
    position = response.position;

    if (response.errorMessage != null) {
      showInfoDialog(response.errorMessage!);
    }
    setState(() {});
  }

  String? photo;
  checkIn() async {
    if (isCheckInToday) return;
    if (photo == null) {
      showInfoDialog("Kamu harus photo dulu!");
      return;
    }

    showLoading();
    bool isRecognized = await AttendanceService().checkin(photo: photo!);
    await getCheckInTodayStatus();
    hideLoading();

    if (!isRecognized) {
      return showInfoDialog("Gagal checkin!");
    }

    showInfoDialog("Berhasil checkin!");
  }

  bool isCheckInToday = false;
  Future getCheckInTodayStatus() async {
    isCheckInToday = await AttendanceService().isCheckInToday();
    setState(() {});
  }

  bool isCheckOutToday = false;
  Future getCheckOutTodayStatus() async {
    isCheckOutToday = await AttendanceService().isCheckOutToday();
    setState(() {});
  }

  checkOut() async {
    if (!(isCheckInToday && isCheckOutToday == false)) return;

    showLoading();
    bool isRecognized = await AttendanceService().checkOut(photo: photo!);
    hideLoading();

    await Future.wait([
      getCheckInTodayStatus(),
      getCheckOutTodayStatus(),
    ]);
    setState(() {});

    if (!isRecognized) {
      return showInfoDialog("Gagal checkout!");
    }

    showInfoDialog("Berhasil checkout!");
  }

  resetToday() async {
    showLoading();
    await AttendanceService().resetToday();
    await Future.wait([
      getCheckInTodayStatus(),
      getCheckOutTodayStatus(),
    ]);
    hideLoading();
    setState(() {});
  }
}
