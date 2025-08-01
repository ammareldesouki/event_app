import 'package:event_app/core/constants/colors.dart';
import 'package:event_app/core/models/event_model.dart';
import 'package:event_app/core/services/app_data_services.dart';
import 'package:event_app/core/services/event_services.dart';
import 'package:event_app/modules/event/screens/event_ditailes.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class EventCard extends StatefulWidget {
  final EventModel eventModel;

  const EventCard({super.key, required this.eventModel});

  @override
  State<EventCard> createState() => _EventCardState();
}


class _EventCardState extends State<EventCard> {

  @override
  void initState() {

    super.initState();
  }
  @override
  Widget build(BuildContext context) {


    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) =>
            EventDetailsScreen(eventModel: widget.eventModel)));
      },
      child: Container(


        height: 200,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
                image: AssetImage(widget.eventModel.eventImage),
                fit: BoxFit.cover)
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 50,
                width: 45,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  DateFormat("dd MMM").format(widget.eventModel.dateTime),
                  style: Theme
                      .of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(color: TColors.primary),),
              ),
              Spacer(),
              Container(


              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),

              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal:  8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(widget.eventModel.title, style: Theme
                        .of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(color: Colors.black)),
                    InkWell(
                        onTap: () {
                          widget.eventModel.isFavourite = !widget.eventModel
                              .isFavourite;
                          EventFireBaseFireStore.updateEvent(widget.eventModel);

                        },
                        child: Icon(widget.eventModel.isFavourite == false
                            ? Icons.favorite_border
                            : Icons.favorite, color: TColors.primary,)),
                  ],
                ),
              ),
              )
            ],
          ),
          ),


      ),
    );
  }
}
