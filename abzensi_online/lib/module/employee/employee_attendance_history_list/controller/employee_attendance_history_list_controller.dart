import 'package:flutter/material.dart';
import 'package:hyper_ui/core.dart';

class EmployeeAttendanceHistoryListController
    extends State<EmployeeAttendanceHistoryListView> {
  static late EmployeeAttendanceHistoryListController instance;
  late EmployeeAttendanceHistoryListView view;

  @override
  void initState() {
    instance = this;
    getHistories();
    super.initState();
  }

  @override
  void dispose() => super.dispose();

  @override
  Widget build(BuildContext context) => widget.build(context, this);

  List histories = [];
  getHistories() async {
    histories = await AttendanceService().getHistories();
    setState(() {});
  }
}
