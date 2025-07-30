import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../core/models/event_model.dart';
import '../../core/services/app_data_services.dart';

class MapScreen extends StatefulWidget {
  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  BitmapDescriptor cMarkerIcon = BitmapDescriptor.defaultMarker;
  final Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    AppDataService.currentLocation == null ?
    _getLocationPermission()
        :

        EasyLoading.show(status: "....looding");
    _markers.add(Marker(markerId: MarkerId("current"),
        position: AppDataService.currentLocation ??
            LatLng(52.2165157, 6.9437819),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRose)));
    _addEventMarkers();
    EasyLoading.dismiss();

    print("-------------------${AppDataService.currentLocation
        ?.latitude}-${AppDataService.currentLocation?.longitude}  ------");




  }

  Future<void> _addEventMarkers() async {
    // Ensure events are loaded
    if (AppDataService.events.isEmpty) {
      await AppDataService.getEventList();
    }

    // Add markers for each event
    for (int i = 0; i < AppDataService.events.length; i++) {
      final event = AppDataService.events[i] as EventModel;
      _markers.add(
        Marker(
          markerId: MarkerId(event.id ?? 'event_$i'),
          position: event.locationEvent,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          infoWindow: InfoWindow(
            title: event.title,
            snippet: event.description,
          ),
        ),
      );
    }
    setState(() {

    });
  }


  Future<void> _getLocationPermission() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.always &&
          permission != LocationPermission.whileInUse) {
        LatLng? _currentPosition = AppDataService.getcurrentLocation();
        _markers.add(Marker(markerId: MarkerId("current"),
            position: _currentPosition ??
                LatLng(52.2165157, 6.9437819)));

        print("${_currentPosition?.latitude} ${_currentPosition?.longitude}");
        return;
      }
    }
  }



  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [

          GoogleMap(
            mapType: MapType.normal,

            initialCameraPosition: CameraPosition(
              target: AppDataService.currentLocation ??
                  LatLng(52.2165157, 6.9437819),
              zoom: 15,

            ),

            markers: _markers,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
          ),

          // Positioned(
          //   bottom: 0,
          //   left: 0,
          //   right: 0,
          //   child: Padding(
          //     padding: const EdgeInsets.all(8.0),
          //     child: SizedBox(
          //       height: 100,
          //
          //       child: ListView.separated(
          //         shrinkWrap: true,
          //         itemCount: AppDataService.events.length,
          //         scrollDirection: Axis.horizontal,
          //         itemBuilder: (_, index) {
          //           return MapEventCard(
          //             eventModel: AppDataService.events[index],
          //           );
          //         },
          //         separatorBuilder: (_, index) => SizedBox(width: 10),
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
