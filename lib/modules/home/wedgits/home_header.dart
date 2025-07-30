import 'package:event_app/core/constants/colors.dart';
import 'package:event_app/core/constants/image_strings.dart';
import 'package:event_app/core/route/route_name.dart';
import 'package:event_app/core/services/app_data_services.dart';
import 'package:event_app/core/services/auth_services.dart';
import 'package:event_app/core/services/theme_service.dart';
import 'package:event_app/modules/event/catagoryList.dart';
import 'package:event_app/modules/home/wedgits/catagory_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    void initState() {
      super.initState();
    }

  @override
  Widget build(BuildContext context) {
    final themeService = Provider.of<ThemeService>(context);

    return Stack(
      children: [
        Container(
          height: MediaQuery
              .sizeOf(context)
              .height * 0.3,
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
                  IconButton(
                    onPressed: () {
                      themeService.toggleTheme();
                    },
                    icon: Icon(
                      themeService.isDarkMode ? Icons.wb_sunny : Icons
                          .nightlight_round,
                      color: Colors.white,
                    ),
                  ),
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
                await AuthService.disconnect();
                await AuthService.signOut();
                Navigator.pushReplacementNamed(context, RouteNames.login);
              },
              icon: Icon(Icons.exit_to_app),
            ),
                ],
              ),
    
              Text(
                AppDataService.currentUserData?.name ?? "null",
                style: Theme.of(
                  context,
                ).textTheme.titleLarge!.copyWith(color: Colors.white),
              ),
    
              Row(
                children: [
                  Image(image: AssetImage(TImages.mapIcon),height: 25,),
                  SizedBox(width: 10),
                  Text(
                    "Cairo , Egypt",
                    style: Theme.of(context).textTheme.titleSmall!
                        .copyWith(color: Colors.white),
                  ),
                ],
              ),
              DefaultTabController(
                  length: Data.categories.length + 1, child: TabBar(
                  onTap: (index) {
                    selectedIndex = index;
                    setState(() {

                    });
                  },

                  isScrollable: true,
                  tabAlignment: TabAlignment.start,
                  indicatorColor: Colors.white,
                  dividerColor: Colors.transparent,
                  indicator:
                  BoxDecoration(),


                  tabs: [
                    Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: selectedIndex == 0 ? TColors.white : TColors
                            .primary,
                        border: Border.all(color: selectedIndex == 0
                            ? TColors.primary
                            : TColors.white),
                        borderRadius: BorderRadius.circular(46),

                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Icon(Icons.explore_rounded,
                              color: selectedIndex == 0
                                  ? TColors.primary
                                  : TColors.white,),
                            SizedBox(width: 5),
                            Text(
                              "All",
                              style: Theme
                                  .of(
                                context,
                              )
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(
                                  color: selectedIndex == 0
                                      ? TColors.primary
                                      : TColors.white),
                            ),
                          ],
                        ),
                      ),
                    ),

                    ...Data.categories.map((category) {
                    return CatagoryCard(catagoryModel: category,
                      isSelected: selectedIndex - 1 ==
                          Data.categories.indexOf(category),);
                  }).toList()

                  ]
              ))

      ]),

        )
      ]);
  }

}
