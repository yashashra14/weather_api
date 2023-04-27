import 'package:geolocator/geolocator.dart';
import 'dart:async';

class GeoLocatorService {
  //gps variables
  bool servicestatus = false;
  bool haspermission = false;
  late LocationPermission permission;
  late Position position;
  String long = "", lat = "";
  late StreamSubscription<Position> positionStream;

  Future<bool> getServiceStatus() async {
    bool status = await Geolocator.isLocationServiceEnabled();
    return status;
  }

  Future<LocationPermission> getPermissions() async {
    LocationPermission permission = await Geolocator.checkPermission();
    return permission;
  }

  Future<Position> getLocationMethod() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    return position;
  }

  Future<Position?> checkGps() async {
    GeoLocatorService service = GeoLocatorService();
    servicestatus = await service.getServiceStatus();
    if (servicestatus) {
      permission = await service.getPermissions();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          print('Location permissions are denied');
        } else if (permission == LocationPermission.deniedForever) {
          print("'Location permissions are permanently denied");
        } else {
          haspermission = true;
        }
      } else {
        haspermission = true;
      }

      if (haspermission) {
        Position position = await getLocation();
        return position;
      }
    } else {
      print("GPS Service is not enabled, turn on GPS location");
    }
  }

  Future<Position> getLocation() async {
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    print(position.longitude); //Output: 80.24599079
    print(position.latitude); //Output: 29.6593457

    long = position.longitude.toString();
    lat = position.latitude.toString();

    LocationSettings locationSettings = const LocationSettings(
      accuracy: LocationAccuracy.high, //accuracy of the location data
      distanceFilter: 100, //minimum distance (measured in meters) a
      //device must move horizontally before an update event is generated;
    );

    StreamSubscription<Position> positionStream =
        Geolocator.getPositionStream(locationSettings: locationSettings)
            .listen((Position position) {
      print(position.longitude); //Output: 80.24599079
      print(position.latitude); //Output: 29.6593457

      long = position.longitude.toString();
      lat = position.latitude.toString();
    });
    return position;
  }
}
