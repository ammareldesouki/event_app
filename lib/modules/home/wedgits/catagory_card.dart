import 'package:event_app/core/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/models/catagory_model.dart';
import '../../../core/services/app_setting_provider.dart';

class CatagoryCard extends StatelessWidget {
  final CategoryModel catagoryModel;
  final bool isSelected;


  const CatagoryCard(
      {super.key, required this.catagoryModel, required this.isSelected});
  
  @override
  Widget build(BuildContext context) {
    final appSetting = Provider.of<AppSettingProvider>(context);


  return Container(
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(46),

        color: isSelected ?  appSetting.isDarkMode? TColors.primary: Colors.white :  appSetting.isDarkMode? TColors.dark:TColors.primary,

        border: Border.all(        color: isSelected ?  appSetting.isDarkMode? TColors.primary: TColors.primary:  appSetting.isDarkMode? TColors.primary:Colors.white,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Icon(catagoryModel.icon,
              color: isSelected ?  appSetting.isDarkMode? Colors.white: TColors.primary :  appSetting.isDarkMode? TColors.white:Colors.white,),
            SizedBox(width: 5),
            Text(
              catagoryModel.name,
              style: Theme.of(
                context,
              )
                  .textTheme
                  .titleSmall!
                  .copyWith(
                color: isSelected ?  appSetting.isDarkMode? Colors.white: TColors.primary :  appSetting.isDarkMode? TColors.white:Colors.white,),
            ),
          ],
        ),
      ),
    );
  }
}
