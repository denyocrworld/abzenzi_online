import 'package:flutter/material.dart';
import 'package:hyper_ui/core.dart';

class EmployeeDashboardView extends StatefulWidget {
  EmployeeDashboardView({Key? key}) : super(key: key);

  Widget build(context, EmployeeDashboardController controller) {
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
        child: Column(
          children: [
            DashboardSlider(),
            DashboardMenu(),
          ],
        ),
      ),
    );
  }

  @override
  State<EmployeeDashboardView> createState() => EmployeeDashboardController();
}
