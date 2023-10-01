import 'package:flutter/foundation.dart';
import 'package:hyper_ui/module/dashboard/widget/dashboard_slider.dart';
import 'package:hyper_ui/shared/app/widget/logo/logo.dart';
import 'package:hyper_ui/shared/widget/form/image_picker/camera_picker.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter/material.dart';
import 'package:hyper_ui/core.dart';
import 'package:latlong2/latlong.dart';

class DashboardView extends StatefulWidget {
  DashboardView({Key? key}) : super(key: key);

  Widget build(context, DashboardController controller) {
    controller.view = this;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            QLogo(
              height: 32.0,
              text: true,
            ),
          ],
        ),
        actions: const [],
      ),
      body: SingleChildScrollView(
        child: const Column(
          children: [
            DashboardSlider(),
          ],
        ),
      ),
    );
  }

  @override
  State<DashboardView> createState() => DashboardController();
}
