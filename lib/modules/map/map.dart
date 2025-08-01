import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_app/modules/map/wedgits/map_event_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../core/models/event_model.dart';
import '../../core/services/app_data_services.dart';
import '../../core/services/event_services.dart';

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
    EasyLoading.dismiss();








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

          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 100,
                  child: StreamBuilder(
                    stream: EventFireBaseFireStore.getStreemeventList(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else
                      if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                        return Center(child: Text('No events found'));
                      }

                      final eventList = snapshot.data!.docs.map((doc) =>
                          doc.data()).toList();


                      return ListView.separated(

                        shrinkWrap: true,
                        itemCount: eventList.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (_, index) {
                          return MapEventCard(
                            eventModel: eventList[index],

                          );
                        },
                        separatorBuilder: (_, index) => SizedBox(width: 10),

                      );
                    },
                  ),

                  // child: ListView.separated(
                  //   shrinkWrap: true,
                  //   itemCount: AppDataService.events.length,
                  //   scrollDirection: Axis.horizontal,
                  //   itemBuilder: (_, index) {
                  //     return MapEventCard(
                  //       eventModel: AppDataService.events[index],
                  //     );
                  //   },
                  //   separatorBuilder: (_, index) => SizedBox(width: 10),
                  // ),
                )
            ),
          ),
        ],
      ),
    );
  }
}
