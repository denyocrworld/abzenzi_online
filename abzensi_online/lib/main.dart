import 'package:geolocator/geolocator.dart';
import 'package:hyper_ui/core.dart';
import 'package:flutter/material.dart';

void main() async {
  await initialize();
  runMainApp();
}

runMainApp() async {
  return runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  bool ready = false;
  bool isNotSafeDevice = false;
  Position? position;
  late LocationServiceResponse locationServiceResponse;

  @override
  void initState() {
    initData();
    super.initState();
  }

  initData() async {
    await getDeviceStatus();
    await getLocation();
    ready = true;
    setState(() {});
  }

  getLocation() async {
    locationServiceResponse = await LocationService.getCurrentLocation();
    position = locationServiceResponse.position;
  }

  getDeviceStatus() async {
    isNotSafeDevice = await SecurityService.isNotSaveDevice();
  }

  Widget get mainView {
    if (!ready) return Container();
    if (isNotSafeDevice) return SafeDeviceInfoView();
    if (position == null)
      return LocationDisabledView(
        locationServiceResponse: locationServiceResponse,
      );

    return LoginView();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Capek Ngoding',
      navigatorKey: Get.navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: getDefaultTheme(),
      // home: mainView,
      home: mainView,
      builder: (context, child) => DebugView(
        context: context,
        child: child,
        visible: true,
      ),
    );
  }
}
