import 'package:flutter/material.dart';
import 'package:hyper_ui/core.dart';

class EmployeeAttendanceHistoryListView extends StatefulWidget {
  EmployeeAttendanceHistoryListView({Key? key}) : super(key: key);

  Widget build(context, EmployeeAttendanceHistoryListController controller) {
    controller.view = this;

    return Scaffold(
      body: ListView.builder(
        itemCount: controller.histories.length,
        padding: EdgeInsets.all(12.0),
        physics: ScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          var item = controller.histories[index];

          var checkInDate = DateTime.tryParse(item["check_in_date"]);
          var checkOutDate = item["check_out_date"] == null
              ? null
              : DateTime.tryParse(item["check_out_date"]);

          var day = DateFormat("dd").format(checkInDate!);
          var month = DateFormat("MMM").format(checkInDate);

          var fCheckInDate = "-";
          var fCheckOutDate = "-";

          fCheckInDate = DateFormat("kk:mm").format(checkInDate);
          fCheckOutDate = checkOutDate == null
              ? "-"
              : DateFormat("kk:mm").format(checkOutDate);

          return Container(
            padding: const EdgeInsets.all(12.0),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(
                  8.0,
                ),
              ),
              boxShadow: [
                BoxShadow(
                  color: Color(0x19000000),
                  blurRadius: 24,
                  offset: Offset(0, 11),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  width: 42.0,
                  height: 42.0,
                  child: Column(
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
                          fontSize: 12.0,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 6.0,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item["check_in_device_id"],
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                      const SizedBox(
                        height: 6.0,
                      ),
                      Row(
                        children: [
                          Text(
                            "$fCheckInDate",
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            width: 8.0,
                          ),
                          Text(
                            "$fCheckOutDate",
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 6.0,
                ),
                CircleAvatar(
                  backgroundImage: NetworkImage(
                    item["check_in_photo"],
                  ),
                )
              ],
            ),
          );

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
  State<EmployeeAttendanceHistoryListView> createState() =>
      EmployeeAttendanceHistoryListController();
}
