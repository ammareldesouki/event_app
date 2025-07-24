import 'package:event_app/core/constants/colors.dart';
import 'package:event_app/core/constants/image_strings.dart';
import 'package:event_app/core/models/catagory_model.dart';
import 'package:event_app/core/models/event_model.dart';
import 'package:flutter/material.dart';

class EventCard extends StatefulWidget {
  final EventModel eventModel;

  const EventCard({super.key, required this.eventModel});

  @override
  State<EventCard> createState() => _EventCardState();
}


class _EventCardState extends State<EventCard> {
  CategoryModel? categoryModel;

  @override
  void initState() {
    categoryModel =
        CategoryModel.getCategoryByName(widget.eventModel.categoryName);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                  image: AssetImage(categoryModel!.imagePath),
                  fit: BoxFit.cover)
          )
        ),
        Positioned(
          top: 4,
          left: 4,
          child: Container(
            height: 49,
            width: 43,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                Expanded(child: Text(
                  widget.eventModel.dateTime.day.toString(), style: Theme
                    .of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: TColors.primary),)),
                Text(widget.eventModel.dateTime.month.toString(), style: Theme
                    .of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: TColors.primary)),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 40,
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
                        .bodyLarge),
                    Image(image: AssetImage(TImages.heartBBIcon))
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
