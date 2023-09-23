import 'package:flutter/material.dart';
import 'package:hyper_ui/core.dart';
import '../controller/attendance_history_navigation_controller.dart';

class AttendanceHistoryNavigationView extends StatefulWidget {
  const AttendanceHistoryNavigationView({Key? key}) : super(key: key);

  Widget build(context, AttendanceHistoryNavigationController controller) {
    controller.view = this;

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            tabs: [
              Tab(
                text: "List",
              ),
              Tab(
                text: "Calendar",
              ),
            ],
          ),
          title: const Text('Order List'),
        ),
        body: TabBarView(
          children: [
            AttendanceHistoryListView(),
            AttendanceHistoryCalendarView(),
          ],
        ),
      ),
    );
  }

  @override
  State<AttendanceHistoryNavigationView> createState() =>
      AttendanceHistoryNavigationController();
}
