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

      decoration: BoxDecoration(color: Color(0xffF2FEFF),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: TColors.primary)),


      child: Row(
        spacing: 10,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: AssetImage(eventModel.eventImage),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 10,
            children: [
              Expanded(
                child: Text(
                  eventModel.title,
                  style: Theme
                      .of(
                    context,
                  )
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: TColors.primary),
                ),
              ),
              Expanded(child: Text(eventModel.locationEvent.toString())),
            ],
          ),
        ],
      ),
    );
  }
}
