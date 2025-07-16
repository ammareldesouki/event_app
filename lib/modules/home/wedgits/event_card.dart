import 'package:event_app/core/constants/colors.dart';
import 'package:event_app/core/constants/image_strings.dart';
import 'package:flutter/material.dart';

class EventCard extends StatelessWidget {
  const EventCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
              image:  DecorationImage(image:  AssetImage(TImages.bookclubImage),fit: BoxFit.cover )
          ),
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
                Text("21",style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: TColors.primary),),
                Text("Jan",style: Theme.of(context).textTheme.bodySmall!.copyWith(color: TColors.primary)),
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
                    Text("This is a Birthday Party",style: Theme.of(context).textTheme.bodyLarge),
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
