import 'dart:io';

import 'package:safe_device/safe_device.dart';

class SecurityService {
  static isNotSaveDevice() async {
    if (Platform.isWindows) return false;
    bool isRoot = await SafeDevice.isJailBroken;
    bool isRealDevice = await SafeDevice.isRealDevice;
    bool isMockLocation = await SafeDevice.canMockLocation;
    return isRoot || !isRealDevice || isMockLocation;
  }
}
