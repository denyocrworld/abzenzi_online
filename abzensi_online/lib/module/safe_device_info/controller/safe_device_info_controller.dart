
import 'package:flutter/material.dart';
import 'package:hyper_ui/core.dart';
import '../view/safe_device_info_view.dart';

class SafeDeviceInfoController extends State<SafeDeviceInfoView> {
    static late SafeDeviceInfoController instance;
    late SafeDeviceInfoView view;

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
        
    