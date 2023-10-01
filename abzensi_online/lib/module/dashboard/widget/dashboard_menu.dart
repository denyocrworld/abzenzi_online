// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hyper_ui/core.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class DashboardMenu extends StatelessWidget {
  const DashboardMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List menus = [
      {
        "label": "Absensi",
        "icon": MdiIcons.faceRecognition,
        "view": AttendanceFormView(),
      }
    ];
    return GridView.builder(
      padding: const EdgeInsets.all(20.0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 1.0,
        crossAxisCount: 3,
        mainAxisSpacing: 6,
        crossAxisSpacing: 6,
      ),
      itemCount: menus.length,
      shrinkWrap: true,
      physics: ScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        var item = menus[index];
        return InkWell(
          onTap: () => Get.to(AttendanceFormView()),
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  item["icon"],
                  size: 48.0,
                  color: primaryColor,
                ),
                const SizedBox(
                  height: 8.0,
                ),
                Text(
                  item["label"],
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14.0,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ),
        )
            .animate()
            .move(
              duration: ((index + 1) * 400).ms,
            )
            .fadeIn();
      },
    );
  }
}
