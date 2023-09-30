import 'package:flutter/material.dart';
import 'package:hyper_ui/core.dart';
import '../controller/safe_device_info_controller.dart';

class SafeDeviceInfoView extends StatefulWidget {
  SafeDeviceInfoView({Key? key}) : super(key: key);

  Widget build(context, SafeDeviceInfoController controller) {
    controller.view = this;

    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.dangerous,
                  size: 32.0,
                  color: Colors.red,
                ),
                const SizedBox(
                  width: 12.0,
                ),
                Text(
                  "Security Warning",
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 20.0,
            ),
            Text(
              "Your device is suspected of using third-party applications. Please use a secure device.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  State<SafeDeviceInfoView> createState() => SafeDeviceInfoController();
}
