import 'package:flutter/material.dart';
import 'package:hyper_ui/core.dart';
import '../view/caffe_dashboard_view.dart';

class CaffeDashboardController extends State<CaffeDashboardView> {
  static late CaffeDashboardController instance;
  late CaffeDashboardView view;

  @override
  void initState() {
    instance = this;
    super.initState();
  }

  @override
  void dispose() => super.dispose();

  @override
  Widget build(BuildContext context) => widget.build(context, this);
}
