import 'package:flutter/material.dart';
import 'package:hyper_ui/core.dart';
import '../controller/attendance_history_calendar_controller.dart';
import 'package:table_calendar/table_calendar.dart';

class AttendanceHistoryCalendarView extends StatefulWidget {
  const AttendanceHistoryCalendarView({Key? key}) : super(key: key);

  Widget build(context, AttendanceHistoryCalendarController controller) {
    controller.view = this;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            TableCalendar<Map<DateTime, List<Map<dynamic, dynamic>>>>(
              firstDay: DateTime.utc(2010, 10, 16),
              lastDay: DateTime.utc(2030, 3, 14),
              focusedDay: DateTime.now(),
              eventLoader: controller.getEvents,
              calendarBuilders: CalendarBuilders(),
            )
          ],
        ),
      ),
    );
  }

  @override
  State<AttendanceHistoryCalendarView> createState() =>
      AttendanceHistoryCalendarController();
}
