import 'package:event_app/core/models/event_model.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart'; // Add this
import '../../../core/constants/colors.dart';

class MapEventCard extends StatefulWidget {
  final EventModel eventModel;

  const MapEventCard({super.key, required this.eventModel});

  @override
  State<MapEventCard> createState() => _MapEventCardState();
}

class _MapEventCardState extends State<MapEventCard> {
  String locationText = "Loading...";

  @override
  void initState() {
    super.initState();
    _getLocation();
  }

  Future<void> _getLocation() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        widget.eventModel.locationEvent.latitude,
        widget.eventModel.locationEvent.longitude,
      );

      if (placemarks.isNotEmpty) {
        final place = placemarks.first;
        setState(() {
          locationText = "${place.locality ?? ""}, ${place.country ?? ""}";
        });
      } else {
        setState(() {
          locationText = "Unknown location";
        });
      }
    } catch (e) {
      setState(() {
        locationText = "Error loading location";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 94,
      width: 361,
      decoration: BoxDecoration(
        color: Color(0xffF2FEFF),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: TColors.primary),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: AssetImage(widget.eventModel.eventImage),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                Text(
                widget.eventModel.title,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: TColors.primary),
                ),
                const SizedBox(height: 8),
                Text(locationText),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
