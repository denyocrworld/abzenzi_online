import 'package:flutter/material.dart';
import 'package:hyper_ui/core.dart';

class EmployeeAttendanceHistoryNavigationView extends StatefulWidget {
  const EmployeeAttendanceHistoryNavigationView({Key? key}) : super(key: key);

  Widget build(
      context, EmployeeAttendanceHistoryNavigationController controller) {
    controller.view = this;

    return DefaultTabController(
      length: 2,
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
            EmployeeAttendanceHistoryListView(),
            EmployeeAttendanceHistoryCalendarView(),
          ],
        ),
      ),
    );
  }

  @override
  State<EmployeeAttendanceHistoryNavigationView> createState() =>
      EmployeeAttendanceHistoryNavigationController();
}
