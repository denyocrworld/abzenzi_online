import 'package:flutter/material.dart';
import 'package:hyper_ui/core.dart';
import '../controller/employee_attendance_history_calendar_controller.dart';
import 'package:table_calendar/table_calendar.dart';

class EmployeeAttendanceHistoryCalendarView extends StatefulWidget {
  const EmployeeAttendanceHistoryCalendarView({Key? key}) : super(key: key);

  Widget build(
      context, EmployeeAttendanceHistoryCalendarController controller) {
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
  State<EmployeeAttendanceHistoryCalendarView> createState() =>
      EmployeeAttendanceHistoryCalendarController();
}
