import 'package:flutter/material.dart';
import 'package:hyper_ui/core.dart';

class EmployeeMainNavigationController
    extends State<EmployeeMainNavigationView> {
  static late EmployeeMainNavigationController instance;
  late EmployeeMainNavigationView view;

  @override
  void initState() {
    instance = this;
    super.initState();
  }

  @override
  void dispose() => super.dispose();

  @override
  Widget build(BuildContext context) => widget.build(context, this);

  int selectedIndex = 0;
  updateIndex(int newIndex) {
    selectedIndex = newIndex;
    setState(() {});
  }
}
