import 'package:flutter/material.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/image_strings.dart';

class OnBoardingContainer extends StatelessWidget {
  final int boardingnum;
  final String title;
  final String description;
  const OnBoardingContainer({
    super.key,
    required this.boardingnum,
    required this.title,  this.description='',
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:               Image(image: AssetImage(TImages.logoWord),height: 50,),
          centerTitle: true,
      ),

      body: SafeArea(

        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16 ,vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
spacing: 20,
            children: [

              Image(
                image: AssetImage(
                  "assets/images/onboarding$boardingnum.png",
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 28,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleLarge!.apply(color: TColors.primary),

                  ),
                  Text(
                    description,
                    style: Theme.of(context).textTheme.bodyMedium ,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
