import 'package:flutter/material.dart';
import 'package:hyper_ui/core.dart';
import '../view/attendance_history_navigation_view.dart';

class AttendanceHistoryNavigationController
    extends State<AttendanceHistoryNavigationView> {
  static late AttendanceHistoryNavigationController instance;
  late AttendanceHistoryNavigationView view;

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
