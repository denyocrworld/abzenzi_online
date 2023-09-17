import 'package:geolocator/geolocator.dart';
import 'package:hyper_ui/core.dart';
import 'package:flutter/material.dart';
import 'package:hyper_ui/service/location_service/location_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
  Position? position;
  late LocationServiceResponse locationServiceResponse;
  @override
  void initState() {
    getLocation();
    super.initState();
  }

  getLocation() async {
    locationServiceResponse = await LocationService.getCurrentLocation();
    position = locationServiceResponse.position;
    ready = true;
    setState(() {});
  }

  Widget get mainView {
    if (!ready) return Container();
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
      home: mainView,
      builder: (context, child) => DebugView(
        context: context,
        child: child,
        visible: true,
      ),
    );
  }
}
