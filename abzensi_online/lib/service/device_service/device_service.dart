import 'package:device_info_plus/device_info_plus.dart';

class DeviceService {
  static getDeviceModel() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    return androidInfo.model;
  }
}
