import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hyper_ui/core.dart';
import 'package:latlong2/latlong.dart';

class EmployeeAttendanceFormView extends StatefulWidget {
  const EmployeeAttendanceFormView({Key? key}) : super(key: key);

  Widget build(context, EmployeeAttendanceFormController controller) {
    controller.view = this;

    if (controller.position == null) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Absensi Online"),
        actions: [
          IconButton(
            onPressed: () {
              showInfoDialog(
                "Pastikan kamu foto di tempat yang terang.",
              );
            },
            icon: const Icon(
              Icons.info,
              size: 24.0,
            ),
          ),
        ],
      ),
      body: Container(
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Builder(
                builder: (context) {
                  List<Marker> allMarkers = [
                    Marker(
                      point: LatLng(
                        controller.position!.latitude,
                        controller.position!.longitude,
                      ),
                      builder: (context) => const CircleAvatar(
                        backgroundColor: Colors.green,
                        radius: 20.0,
                        child: Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    ),
                  ];
                  return SizedBox(
                    height: MediaQuery.of(context).size.height * 0.4,
                    child: FlutterMap(
                      options: MapOptions(
                        center: LatLng(
                          controller.position!.latitude - 0.0020,
                          controller.position!.longitude,
                        ),
                        zoom: 16,
                        interactiveFlags:
                            InteractiveFlag.all - InteractiveFlag.rotate,
                      ),
                      children: [
                        TileLayer(
                          urlTemplate:
                              'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                          userAgentPackageName:
                              'dev.fleaflet.flutter_map.example',
                        ),
                        MarkerLayer(
                          markers: allMarkers,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Card(
                    child: Container(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          QCameraPicker(
                            label: "Photo",
                            validator: Validator.required,
                            value: null,
                            onChanged: (value) {
                              controller.photo = value;
                            },
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: QButton(
                                  label: "Check in",
                                  color: controller.isCheckInToday
                                      ? Colors.grey
                                      : Colors.green,
                                  onPressed: () => controller.checkIn(),
                                ),
                              ),
                              const SizedBox(
                                width: 12.0,
                              ),
                              Expanded(
                                child: QButton(
                                  label: "Check out",
                                  color: controller.isCheckInToday &&
                                          controller.isCheckOutToday == false
                                      ? Colors.red
                                      : Colors.grey,
                                  onPressed: () => controller.checkOut(),
                                ),
                              ),
                            ],
                          ),
                          if (kDebugMode)
                            InkWell(
                              onTap: () => controller.resetToday(),
                              child: Container(
                                margin: const EdgeInsets.only(
                                  top: 12.0,
                                ),
                                child: Text(
                                  "Reset",
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  State<EmployeeAttendanceFormView> createState() =>
      EmployeeAttendanceFormController();
}
