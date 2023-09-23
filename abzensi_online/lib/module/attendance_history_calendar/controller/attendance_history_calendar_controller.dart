import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:hyper_ui/core.dart';
import '../view/attendance_history_calendar_view.dart';

class AttendanceHistoryCalendarController
    extends State<AttendanceHistoryCalendarView> {
  static late AttendanceHistoryCalendarController instance;
  late AttendanceHistoryCalendarView view;

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
    //----
    setState(() {});
  }

  List<Map<DateTime, List<Map<dynamic, dynamic>>>> events = [
    // {
    //   DateTime(2023, 9, 23): [
    //     {
    //       "event_name": "Check In",
    //       "time": "09:30",
    //     },
    //     {
    //       "event_name": "Check Out",
    //       "time": "21:30",
    //     }
    //   ],
    // },
    // {
    //   DateTime(2023, 9, 21): [
    //     {
    //       "event_name": "Check In",
    //       "time": "09:30",
    //     },
    //     {
    //       "event_name": "Check Out",
    //       "time": "21:30",
    //     }
    //   ],
    // }
  ];

  List<Map<DateTime, List<Map<dynamic, dynamic>>>> getEvents(DateTime date) {
    var eventDate = DateTime(date.year, date.month, date.day);
    var filteredEvents =
        events.where((event) => event.keys.first == eventDate).toList();
    return filteredEvents;
  }

/*
  List<Map<DateTime, List<Map>>> getEvents() {
    return {
      DateTime.now(): [
        {
          "event_name": "Check In",
          "time": "09:30",
        },
        {
          "event_name": "Check Out",
          "time": "21:30",
        }
      ],
      DateTime.now().subtract(Duration(days: 1)): [
        {
          "event_name": "Check In",
          "time": "08:30",
        },
        {
          "event_name": "Check Out",
          "time": "19:30",
        }
      ],
    };
  }
  */
}
