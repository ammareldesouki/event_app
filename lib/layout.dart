import 'package:event_app/core/constants/colors.dart';
import 'package:event_app/core/constants/image_strings.dart';
import 'package:event_app/core/route/route_name.dart';
import 'package:event_app/favourite/favourite.dart';
import 'package:event_app/l10n/app_localizations.dart';
import 'package:event_app/modules/home/screens/home.dart';
import 'package:event_app/modules/map/map.dart';
import 'package:event_app/modules/profile/profile.dart';
import 'package:flutter/material.dart';


class Layout extends StatefulWidget {

  const Layout({super.key});

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    final List<Widget> screen = [
      Homescreen(),
      MapScreen(),

      FavouriteScreen(),

      ProfileScreen()

    ];
    void onTapItem(int index) {
      setState(() {
        _selectedIndex = index;
      });
    }

    return Scaffold(
      body: screen[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: onTapItem,

        items: [
          BottomNavigationBarItem(
            icon: Container(
              padding: EdgeInsets.symmetric(vertical: 6, horizontal: 20),
              decoration: BoxDecoration(
                color:
                    _selectedIndex == 0 ? Colors.black26 : Colors.transparent,
                borderRadius: BorderRadius.circular(60),
              ),
              child: Image(image: AssetImage(TImages.homeIcon)),
            ),
            label: AppLocalizations.of(context)!.home,
          ),
          BottomNavigationBarItem(
            icon:  Container(
              padding: EdgeInsets.symmetric(vertical: 6, horizontal: 20),
              decoration: BoxDecoration(
                color:
                    _selectedIndex == 1 ? Colors.black26 : Colors.transparent,
                borderRadius: BorderRadius.circular(60),
              ),
              child:Image(image: AssetImage(TImages.mapIcon))),
            label: AppLocalizations.of(context)!.map,
          ),

          BottomNavigationBarItem(
            icon: Container(
              padding: EdgeInsets.symmetric(vertical: 6, horizontal: 20),
              decoration: BoxDecoration(
                color:
                    _selectedIndex == 2 ? Colors.black26 : Colors.transparent,
                borderRadius: BorderRadius.circular(60),
              ),
              child: Image(image: AssetImage(TImages.heartIcon))),
            label: AppLocalizations.of(context)!.favourite,
          ),


          BottomNavigationBarItem(
            icon: Container(
              padding: EdgeInsets.symmetric(vertical: 6, horizontal: 20),
              decoration: BoxDecoration(
                color:
                    _selectedIndex == 3 ? Colors.black26 : Colors.transparent,
                borderRadius: BorderRadius.circular(60),
              ),
              child: Image(image: AssetImage(TImages.profileIcon))),
            label: AppLocalizations.of(context)!.profile,
          ),

          // BottomNavigationBarItem(
          //   icon: Container(
          //     padding: EdgeInsets.symmetric(vertical: 6, horizontal: 20),
          //     decoration: BoxDecoration(
          //       color:
          //           _selectedIndex == 4 ? Colors.black26 : Colors.transparent,
          //       borderRadius: BorderRadius.circular(60),
          //     ),
          //     child: Image(image: AssetImage(TImages.timeIcon))),
          //   label: 'Time',
          // ),
        ],
      ),

      floatingActionButton: InkWell(
        onTap: () {
          Navigator.pushNamed(context, RouteNames.addEvent);
        },
        child: CircleAvatar(
          radius: 30,
          backgroundColor: Colors.white,
          child: CircleAvatar(
            radius: 22,
            child: Icon(Icons.add, color: Colors.white),
            backgroundColor: TColors.primary,
          ),

        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
