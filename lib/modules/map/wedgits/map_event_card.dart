import 'package:event_app/core/models/event_model.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/colors.dart';

class MapEventCard extends StatelessWidget {
  final EventModel eventModel;

  const MapEventCard({super.key, required this.eventModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 94,

      decoration: BoxDecoration(color: Color(0xffF2FEFF)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: AssetImage(eventModel.eventImage),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                eventModel.title,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium!.copyWith(color: TColors.primary),
              ),
              Text(eventModel.locationEvent.toString()),
            ],
          ),
        ],
      ),
    );
  }
}
