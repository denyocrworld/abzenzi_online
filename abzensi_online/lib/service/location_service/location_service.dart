import 'package:geolocator/geolocator.dart';

class LocationServiceResponse {
  final Position? position;
  final String? errorMessage;
  LocationServiceResponse({
    this.position,
    this.errorMessage,
  });
}

class LocationService {
  static Future<LocationServiceResponse> getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      print('Location services are disabled.');
      return LocationServiceResponse(
        errorMessage: 'Location services are disabled.',
      );
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return LocationServiceResponse(
          errorMessage: 'Location permissions are denied',
        );
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return LocationServiceResponse(
        errorMessage:
            'Location permissions are permanently denied, we cannot request permissions.',
      );
    }
    Position position = await Geolocator.getCurrentPosition();
    return LocationServiceResponse(
      position: position,
    );
  }
}
