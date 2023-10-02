import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hyper_ui/shared/theme/theme_config.dart';

class QLogo extends StatelessWidget {
  final double? width;
  final double? height;
  final bool text;
  const QLogo({
    Key? key,
    this.width,
    this.height,
    this.text = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: FittedBox(
        child: Row(
          children: [
            Icon(
              MdiIcons.radiusOutline,
              color: primaryColor,
            ),
            if (text) ...[
              const SizedBox(
                width: 4.0,
              ),
              Text(
                "Attend",
                style: TextStyle(
                  fontSize: 14.0,
                  color: warningColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Me",
                style: TextStyle(
                  fontSize: 14.0,
                  color: primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ],
        ),
      ),
    )
        .animate()
        .scale(
          duration: 600.ms,
        )
        .move(
          duration: 600.ms,
        )
        .fadeIn(
          duration: 800.ms,
        );
  }
}
