import 'package:event_app/core/constants/colors.dart';
import 'package:flutter/material.dart';

import '../../../core/models/catagory_model.dart';

class CreateEventCatagoryCard extends StatelessWidget {
  final CategoryModel catagoryModel;
  final bool isSelected;

  const CreateEventCatagoryCard({
    super.key,
    required this.catagoryModel,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: isSelected ? TColors.primary : TColors.white,
        border: Border.all(color: TColors.primary),
        borderRadius: BorderRadius.circular(46),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Icon(
              catagoryModel.icon,
              color: isSelected ? TColors.white : TColors.primary,
            ),
            SizedBox(width: 5),
            Text(
              catagoryModel.name,
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                color: isSelected ? TColors.white : TColors.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
