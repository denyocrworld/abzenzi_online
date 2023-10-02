import 'package:dio/dio.dart';
import 'package:hyper_ui/env.dart';
import 'package:hyper_ui/service/device_service/device_service.dart';
import 'package:hyper_ui/service/location_service/location_service.dart';

class AttendanceService {
  Future<(String, bool)> doSomething() async {
    return ("OK", false);
  }

  Future<(bool, String)> checkin({
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
      Map data = response.data["data"];
      double distance = data["distance"];
      bool isRecognized = data["is_recognized"];
      bool isTooFar = data["is_too_far"];
      print("Distance: $distance");

      if (isTooFar) {
        return (false, "Jarak terlalu jauh");
      }

      if (!isRecognized) {
        return (false, "Wajah tidak dikenali");
      }

      return (true, "");
    } on Exception catch (_) {
      return (false, "Ada masalah pada API");
    }
  }

  Future<(bool, String)> checkOut({
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
      Map data = response.data["data"];
      double distance = data["distance"];
      bool isRecognized = data["is_recognized"];
      bool isTooFar = data["is_too_far"];
      print("Distance: $distance");

      if (isTooFar) {
        return (false, "Jarak terlalu jauh");
      }

      if (!isRecognized) {
        return (false, "Wajah tidak dikenali");
      }

      return (true, "");
    } on Exception catch (_) {
      print(_);
      return (false, "Ada masalah pada API");
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

  Future<List> getHistories() async {
    try {
      var response = await Dio().get(
        "${Env.baseUrl}/api/attendance/histories",
        options: Env.options,
      );
      Map obj = response.data;
      return obj["data"];
    } on Exception catch (_) {
      throw (_);
    }
  }

  Future resetToday() async {
    try {
      await Dio().post(
        "${Env.baseUrl}/api/attendance/reset-today",
        options: Env.options,
      );
    } on Exception catch (_) {}
  }
}
