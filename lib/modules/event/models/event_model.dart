import 'package:flutter/material.dart';

class EventModel {
  final String title;
  final String description;
  final String dateTime;
  final TimeOfDay timeOfDay;
  final String catagorName;

  EventModel(
    this.title,
    this.description,
    this.dateTime,
    this.timeOfDay,
    this.catagorName,
  );
}
