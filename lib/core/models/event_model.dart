import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

class EventModel {
  static String collectionName = 'events';

  final String? id;
  String title;
  String description;
  DateTime dateTime;
  String timeString; // Store time as a string (e.g., '14:30')
  final String categoryName;
  final String eventImage;
  bool isFavourite;
  final LatLng locationEvent;


  EventModel({
    required this.locationEvent,
    this.id,
    required this.title,
    required this.description,
    required this.dateTime,
    required this.timeString,
    required this.categoryName,
    required this.eventImage,
    this.isFavourite = false,

  });

  Map<String, dynamic> toFireStor() {
    return {
      "title": title,
      "description": description,
      "dateTime": dateTime.millisecondsSinceEpoch,
      "timeString": timeString,
      "categoryName": categoryName,
      "eventImage": eventImage,
      "isFavourite": isFavourite,
      "Location": GeoPoint(
          this.locationEvent.latitude, this.locationEvent.longitude)
    };
  }

  factory EventModel.fromFirestore(Map<String, dynamic> json, {String? id}) {
    final loc = json['Location'] as GeoPoint;

    return EventModel(
        id: id,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
        dateTime: DateTime.fromMillisecondsSinceEpoch(json['dateTime']),
      timeString: json['timeString'] ?? '',
      categoryName: json['categoryName'] ?? '',
        eventImage: json['eventImage'] ?? '',
        isFavourite: json['isFavourite'] ?? false,
        locationEvent: LatLng(loc.latitude, loc.longitude)

    );
  }

  // Convert TimeOfDay to string
  static String timeOfDayToString(TimeOfDay tod) =>
      '${tod.hour.toString().padLeft(2, '0')}:${tod.minute.toString().padLeft(
          2, '0')}';

  // Convert string to TimeOfDay
  static TimeOfDay timeOfDayFromString(String tod) {
    final parts = tod.split(':');
    return TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
  }
}
