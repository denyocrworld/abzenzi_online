import 'package:flutter/material.dart';
import 'package:hyper_ui/core.dart';
import '../view/attendance_history_list_view.dart';

class AttendanceHistoryListController extends State<AttendanceHistoryListView> {
  static late AttendanceHistoryListController instance;
  late AttendanceHistoryListView view;

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
