import 'package:flutter/material.dart';
import 'package:hyper_ui/core.dart';

class EmployeeMainNavigationView extends StatefulWidget {
  EmployeeMainNavigationView({Key? key}) : super(key: key);

  Widget build(context, EmployeeMainNavigationController controller) {
    controller.view = this;

    return DefaultTabController(
      length: 3,
      initialIndex: controller.selectedIndex,
      child: Scaffold(
        body: IndexedStack(
          index: controller.selectedIndex,
          children: [
            EmployeeDashboardView(),
            EmployeeAttendanceHistoryNavigationView(),
            EmployeeProfileView(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: controller.selectedIndex,
          onTap: (newIndex) => controller.updateIndex(newIndex),
          selectedItemColor: primaryColor,
          items: [
            BottomNavigationBarItem(
              icon: Container(
                child: Icon(
                  MdiIcons.viewDashboard,
                ),
              ),
              label: "Dashboard",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                MdiIcons.history,
              ),
              label: "Histories",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
              ),
              label: "User",
            ),
          ],
        ),
      ),
    );
  }

  @override
  State<EmployeeMainNavigationView> createState() =>
      EmployeeMainNavigationController();
}
