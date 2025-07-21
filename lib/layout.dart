import 'package:event_app/core/constants/colors.dart';
import 'package:event_app/core/constants/image_strings.dart';
import 'package:event_app/modules/event/screens/add_event.dart';
import 'package:event_app/modules/home/screens/home.dart';
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
            Homescreen(),
                  AddEventScreen(),

      Homescreen(),

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
            label: 'Home',
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
            label: 'Map',
          ),
          BottomNavigationBarItem(
            icon: Container(
              padding: EdgeInsets.symmetric(vertical: 6, horizontal: 20),
              decoration: BoxDecoration(

                borderRadius: BorderRadius.circular(60),
              ),
            ),
            label: '',
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
            label: 'Love',
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
            label: 'Profile',
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
          setState(() {
            _selectedIndex = 2;
          });
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
