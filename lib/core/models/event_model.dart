import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EventModel {
  static String collectionName = 'events';
  final int id;
  final String title;
  final String description;
  final DateTime dateTime;
  final String timeString; // Store time as a string (e.g., '14:30')
  final String categoryName;
  final String eventImage;
  Map<String, dynamic> toFireStor() {
    return {
      "id": this.id,
      "title": this.title,
      "description": this.description,
      "dateTime": this.dateTime,
      "timeString": this.timeString, // Store as string
      "categoryName": this.categoryName,
      "eventImage": this.eventImage
    };
  }

  factory EventModel.fromFirestore(Map<String, dynamic> json) {
    final fullDateTime = (json['dateTime'] as Timestamp).toDate();
    return EventModel(
      id: json['id'],
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      dateTime: DateTime(
          fullDateTime.year, fullDateTime.month, fullDateTime.day),
      timeString: json['timeString'] ?? '',
      categoryName: json['categoryName'] ?? '',
        eventImage: json['eventImage']

    );
  }

  EventModel({
    required this.id,
    required this.title,
    required this.description,
    required this.dateTime,
    required this.timeString,
    required this.categoryName,
    required this.eventImage
  });

  // Helper: Convert TimeOfDay to String
  static String timeOfDayToString(TimeOfDay tod) =>
      '${tod.hour.toString().padLeft(2, '0')}:${tod.minute.toString().padLeft(
          2, '0')}';

  // Helper: Convert String to TimeOfDay
  static TimeOfDay timeOfDayFromString(String tod) {
    final parts = tod.split(':');
    return TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
  }
}
