import 'package:flutter/material.dart';
import 'package:hyper_ui/core.dart';

class MainNavigationView extends StatefulWidget {
  MainNavigationView({Key? key}) : super(key: key);

  Widget build(context, MainNavigationController controller) {
    controller.view = this;

    return DefaultTabController(
      length: 3,
      initialIndex: controller.selectedIndex,
      child: Scaffold(
        body: IndexedStack(
          index: controller.selectedIndex,
          children: [
            DashboardView(),
            AttendanceHistoryNavigationView(),
            ProfileView(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: controller.selectedIndex,
          onTap: (newIndex) => controller.updateIndex(newIndex),
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                MdiIcons.viewDashboard,
              ),
              label: "Dashboard",
            ),
            BottomNavigationBarItem(
              icon: Badge(
                label: Text(
                  "4",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                child: Icon(MdiIcons.history),
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
  State<MainNavigationView> createState() => MainNavigationController();
}
