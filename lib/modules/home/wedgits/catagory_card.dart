import 'package:event_app/core/constants/colors.dart';
import 'package:event_app/core/constants/image_strings.dart';
import 'package:flutter/material.dart';

class CatagoryCard extends StatelessWidget {

  final String title;
  final String imageUrl;
  

  const CatagoryCard({super.key, required this.title, required this.imageUrl});
  
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: TColors.primary,
        borderRadius: BorderRadius.circular(46),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Image(image: AssetImage(imageUrl)),
            SizedBox(width: 5),
            Text(
              title,
              style: Theme.of(
                context,
              ).textTheme.titleSmall!.copyWith(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
