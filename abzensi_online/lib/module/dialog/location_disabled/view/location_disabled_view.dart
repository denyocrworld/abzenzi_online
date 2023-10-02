import 'package:flutter/material.dart';
import 'package:hyper_ui/core.dart';

class LocationDisabledView extends StatefulWidget {
  final LocationServiceResponse locationServiceResponse;
  LocationDisabledView({
    Key? key,
    required this.locationServiceResponse,
  }) : super(key: key);

  Widget build(context, LocationDisabledController controller) {
    controller.view = this;

    return Scaffold(
      appBar: AppBar(
        title: Text("LocationDisabled"),
        actions: [],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: [
              Text(
                "${locationServiceResponse.errorMessage}",
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.red,
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              QButton(
                label: "Open App Settings",
                onPressed: () => controller.openMyAppSettings(),
              ),
              const SizedBox(
                height: 12.0,
              ),
              QButton(
                label: "Try login",
                onPressed: () => controller.openLoginView(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  State<LocationDisabledView> createState() => LocationDisabledController();
}
