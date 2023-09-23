import 'package:flutter/material.dart';
import 'package:hyper_ui/core.dart';
import '../controller/attendance_history_list_controller.dart';

class AttendanceHistoryListView extends StatefulWidget {
  AttendanceHistoryListView({Key? key}) : super(key: key);

  Widget build(context, AttendanceHistoryListController controller) {
    controller.view = this;

    return Scaffold(
      body: ListView.builder(
        itemCount: controller.histories.length,
        padding: EdgeInsets.all(12.0),
        physics: ScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          var item = controller.histories[index];

          var checkInDate = DateTime.parse(item["check_in_date"]);
          var day = DateFormat("dd").format(checkInDate);
          var month = DateFormat("MMM").format(checkInDate);

          return Card(
            child: ListTile(
              leading: Column(
                children: [
                  Expanded(
                    child: FittedBox(
                      child: Text(
                        "$day",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    "$month",
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
              title: Text(item["check_in_device_id"]),
              subtitle: Text("Programmer"),
              trailing: CircleAvatar(
                backgroundImage: NetworkImage(
                  item["check_in_photo"],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  State<AttendanceHistoryListView> createState() =>
      AttendanceHistoryListController();
}
