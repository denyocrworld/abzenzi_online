import 'package:dio/dio.dart';
import 'package:hyper_ui/env.dart';
import 'package:hyper_ui/service/auth_service/auth_service.dart';
import 'package:hyper_ui/service/device_service/device_service.dart';
import 'package:hyper_ui/service/location_service/location_service.dart';

class AttendanceService {
  Future checkin({
    required String photo,
  }) async {
    try {
      var userDevice = await DeviceService.getDeviceModel();
      var locationResponse = await LocationService.getCurrentLocation();
      var position = locationResponse.position!;

      var response = await Dio().post(
        "${Env.baseUrl}/api/attendance/check-in",
        options: Env.options,
        data: {
          "check_in_device_id": userDevice,
          "check_in_latitude": position.latitude,
          "check_in_longitude": position.longitude,
          "check_in_photo": photo,
        },
      );
      Map obj = response.data;
      bool isRecognized = obj["data"]["is_recognized"];
      return isRecognized;
    } on Exception catch (_) {
      print(_);
      return false;
    }
  }

  Future checkOut({
    required String photo,
  }) async {
    try {
      var userDevice = await DeviceService.getDeviceModel();
      var locationResponse = await LocationService.getCurrentLocation();
      var position = locationResponse.position!;

      var response = await Dio().post(
        "${Env.baseUrl}/api/attendance/check-out",
        options: Env.options,
        data: {
          "check_out_device_id": userDevice,
          "check_out_latitude": position.latitude,
          "check_out_longitude": position.longitude,
          "check_out_photo": photo,
        },
      );
      Map obj = response.data;
      bool isRecognized = obj["data"]["is_recognized"];
      return isRecognized;
    } on Exception catch (_) {
      print(_);
      return false;
    }
  }

  Future<bool> isCheckInToday() async {
    try {
      var response = await Dio().post(
        "${Env.baseUrl}/api/attendance/is-check-in-today",
        options: Env.options,
      );
      Map obj = response.data;
      return obj["data"]["is_check_in_today"];
    } on Exception catch (_) {
      return false;
    }
  }

  Future<bool> isCheckOutToday() async {
    try {
      var response = await Dio().post(
        "${Env.baseUrl}/api/attendance/is-check-out-today",
        options: Env.options,
      );
      Map obj = response.data;
      return obj["data"]["is_check_out_today"];
    } on Exception catch (_) {
      return false;
    }
  }
}
