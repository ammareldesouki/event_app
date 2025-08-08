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
  GoogleMapController? _mapController;
  bool _markersInitialized = false;
  List<EventModel> _currentEvents = [];

  @override
  void initState() {
    super.initState();
    _loadCurrentUserData();
    _initializeMap();
  }

  Future<void> _loadCurrentUserData() async {
    await AppDataService.getcurrentUserData();
  }

  Future<void> _initializeMap() async {
    if (AppDataService.currentLocation == null) {
      await _getLocationPermission();
    } else {
      EasyLoading.show(status: "Loading...");
    }
    
    // Add current location marker
    _markers.add(Marker(
      markerId: MarkerId("current"),
      position: AppDataService.currentLocation ?? LatLng(52.2165157, 6.9437819),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRose),
      infoWindow: InfoWindow(title: "Current Location"),
    ));
    
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
        await AppDataService.getcurrentLocation();
        setState(() {
          _markers.clear();
          _markers.add(Marker(
            markerId: MarkerId("current"),
            position: AppDataService.currentLocation ?? LatLng(52.2165157, 6.9437819),
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRose),
            infoWindow: InfoWindow(title: "Current Location"),
          ));
        });
        return;
      }
    }
    
    await AppDataService.getcurrentLocation();
    setState(() {
      _markers.clear();
      _markers.add(Marker(
        markerId: MarkerId("current"),
        position: AppDataService.currentLocation ?? LatLng(52.2165157, 6.9437819),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRose),
        infoWindow: InfoWindow(title: "Current Location"),
      ));
    });
  }

  void _addEventMarkers(List<EventModel> events) {
    // Check if events have changed to avoid unnecessary updates
    if (_markersInitialized && _areEventsEqual(_currentEvents, events)) {
      return;
    }
    
    _currentEvents = List.from(events);
    _markersInitialized = true;
    
    setState(() {
      _markers.clear();
      
      // Add current location marker
      _markers.add(Marker(
        markerId: MarkerId("current"),
        position: AppDataService.currentLocation ?? LatLng(52.2165157, 6.9437819),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRose),
        infoWindow: InfoWindow(title: "Current Location"),
      ));
      
      // Add event markers
      for (int i = 0; i < events.length; i++) {
        final event = events[i];
        _markers.add(Marker(
          markerId: MarkerId("event_${event.id ?? i}"),
          position: event.locationEvent,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
          infoWindow: InfoWindow(
            title: event.title,
            snippet: event.categoryName,
          ),
        ));
      }
    });
  }

  bool _areEventsEqual(List<EventModel> list1, List<EventModel> list2) {
    if (list1.length != list2.length) return false;
    for (int i = 0; i < list1.length; i++) {
      if (list1[i].id != list2[i].id) return false;
    }
    return true;
  }

  void _updateMarkersFromSnapshot(AsyncSnapshot<QuerySnapshot<EventModel>> snapshot) {
    if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
      final eventList = snapshot.data!.docs.map((doc) => doc.data()).toList();
      _addEventMarkers(eventList);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: CameraPosition(
              target: AppDataService.currentLocation ?? LatLng(52.2165157, 6.9437819),
              zoom: 15,
            ),
            markers: _markers,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            onMapCreated: (GoogleMapController controller) {
              _mapController = controller;
            },
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
                  stream: EventFireBaseFireStore.getStreemeventListByUserId(
                    AppDataService.currentUserData?.uid ?? '',
                  ),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return Center(child: Text('No events found'));
                    }

                    final eventList = snapshot.data!.docs.map((doc) => doc.data()).toList();
                    
                    // Update markers after the build is complete
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      if (mounted) {
                        _updateMarkersFromSnapshot(snapshot);
                      }
                    });

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
              ),
            ),
          ),
        ],
      ),
    );
  }
}
