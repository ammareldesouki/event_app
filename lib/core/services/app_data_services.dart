import 'package:event_app/core/models/event_model.dart';
import 'package:event_app/core/services/event_services.dart';
import 'package:event_app/core/services/user_services.dart';
import 'package:event_app/modules/authentication/models/user_model.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AppDataService {
  static UserModel? currentUserData;
  static List<Map<String, dynamic>> userLogs = [];
  static List favEvents = [];
  static LatLng? currentLocation;

  static getcurrentUserData() async {
    currentUserData = await UserService.getCurrentUserData();
  }

  static getcurrentLocation() async {
    Position? position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    currentLocation = LatLng(position.latitude, position.longitude);
  }
}
