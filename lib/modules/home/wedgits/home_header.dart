import 'package:event_app/core/constants/colors.dart';
import 'package:event_app/core/constants/image_strings.dart';
import 'package:event_app/core/route/route_name.dart';
import 'package:event_app/modules/home/wedgits/catagory_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomeHeader extends StatefulWidget {
  const HomeHeader({
    super.key,
  });

  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
    int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
     final List<Map<String, dynamic>> categories = [
    {'label': 'All', 'icon': Icons.circle},
    {'label': 'Sport', 'icon': Icons.directions_bike},
    {'label': 'Birthday', 'icon': Icons.cake},
  
  ];
    return Stack(
      children: [
        Container(
          height: 350,
          decoration: BoxDecoration(
            color: TColors.primary,
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(24),
              bottomLeft: Radius.circular(24),
            ),
          ),
        ),
    
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 40,
            horizontal: 16,
          ),
          child: Column(
            spacing: 10,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "Welcome Back ✨",
                    style: Theme.of(context).textTheme.bodySmall!
                        .copyWith(color: TColors.white),
                  ),
                  Spacer(),
                  Icon(Icons.wb_sunny_outlined, color: Colors.white),
                  SizedBox(width: 10),
                  Container(
                    width: 50,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        "EN",
                        style: Theme.of(context).textTheme.bodyMedium!
                            .copyWith(color: TColors.primary),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                      ),
                    ),
                  ),
                     IconButton(
              onPressed: () async {
                final GoogleSignIn googleSignIn = GoogleSignIn();
                googleSignIn.disconnect();
                await FirebaseAuth.instance.signOut();
                Navigator.pushReplacementNamed(context, RouteNames.login);
              },
              icon: Icon(Icons.exit_to_app),
            ),
                ],
              ),
    
              Text(
                "Ammar Mohamed",
                style: Theme.of(
                  context,
                ).textTheme.titleLarge!.copyWith(color: Colors.white),
              ),
    
              Row(
                children: [
                  Image(image: AssetImage(TImages.mapIcon)),
                  SizedBox(width: 10),
                  Text(
                    "Cairo , Egypt",
                    style: Theme.of(context).textTheme.titleSmall!
                        .copyWith(color: Colors.white),
                  ),
                ],
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
    
                child: Row(
                  children: List.generate(categories.length, (index) {
                        final isSelected = selectedIndex == index;
                        return Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: ChoiceChip(
                            label: Text(
                              categories[index]['label'],
                              style: TextStyle(
                                color: isSelected ? TColors.primary : Colors.white,
                              ),
                            ),
                            avatar: Icon(
                              categories[index]['icon'],
                              size: 18,
                              color: isSelected ? TColors.primary : Colors.white,
                            ),
                            selected: isSelected,
                            selectedColor: Colors.white,
                            backgroundColor: TColors.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side: BorderSide(color: TColors.primary),
                            ),
                            onSelected: (selected) {
                              setState(() {
                                selectedIndex = index;
                              });
                            },
                ),
          
                        );       
                  }, 
                  ),              
          
          ),
        ),
      ]),
        )
      ]);
  }
}
