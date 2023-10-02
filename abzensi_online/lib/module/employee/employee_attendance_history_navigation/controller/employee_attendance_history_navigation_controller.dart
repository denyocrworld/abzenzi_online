import 'package:flutter/material.dart';
import 'package:hyper_ui/core.dart';
import '../view/employee_attendance_history_navigation_view.dart';

class EmployeeAttendanceHistoryNavigationController
    extends State<EmployeeAttendanceHistoryNavigationView> {
  static late EmployeeAttendanceHistoryNavigationController instance;
  late EmployeeAttendanceHistoryNavigationView view;

  @override
  void initState() {
    instance = this;
    super.initState();
  }

  @override
  void dispose() => super.dispose();

  @override
  Widget build(BuildContext context) => widget.build(context, this);
}
