import 'package:event_app/core/constants/colors.dart';
import 'package:event_app/core/models/event_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EventDetailsScreen extends StatelessWidget {
  final EventModel eventModel;

  const EventDetailsScreen({super.key, required this.eventModel});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Event Details",
          style: Theme.of(
            context,
          ).textTheme.titleMedium!.copyWith(color: TColors.primary),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: TColors.primary),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.edit_outlined, color: TColors.primary),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(CupertinoIcons.trash_fill, color: Colors.red),
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          spacing: 10,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                image: DecorationImage(
                  image: AssetImage(eventModel.eventImage),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            Text(
              eventModel.title,
              style: Theme.of(
                context,
              ).textTheme.titleLarge!.copyWith(color: TColors.primary),
            ),
          ],
        ),
      ),
    );
  }
}
