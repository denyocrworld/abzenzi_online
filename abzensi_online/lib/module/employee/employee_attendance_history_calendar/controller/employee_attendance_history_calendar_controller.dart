import 'package:flutter/material.dart';
import 'package:hyper_ui/core.dart';

class EmployeeAttendanceHistoryCalendarController
    extends State<EmployeeAttendanceHistoryCalendarView> {
  static late EmployeeAttendanceHistoryCalendarController instance;
  late EmployeeAttendanceHistoryCalendarView view;

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
    //---
    for (var item in histories) {
      var date = DateTime.parse(item["check_in_date"]);
      var time = DateFormat("kk:mm").format(date);

      events.add({
        DateTime(date.year, date.month, date.day): [
          {
            "event_name": "Check In",
            "time": time,
          },
        ],
      });
    }
    setState(() {});
  }

  List<Map<DateTime, List<Map<dynamic, dynamic>>>> events = [];
  List<Map<DateTime, List<Map<dynamic, dynamic>>>> getEvents(DateTime date) {
    var eventDate = DateTime(date.year, date.month, date.day);
    var filteredEvents =
        events.where((event) => event.keys.first == eventDate).toList();
    return filteredEvents;
  }
}
