import 'package:event_app/core/constants/colors.dart';
import 'package:flutter/material.dart';


class BottomNavTheme {
  static BottomNavigationBarThemeData light = BottomNavigationBarThemeData(
    backgroundColor: TColors.primary,
    selectedItemColor: Colors.white,
    unselectedItemColor: Colors.black,
    selectedIconTheme: IconThemeData(size: 28),
    unselectedIconTheme: IconThemeData(size: 22),
    showSelectedLabels: true,
    showUnselectedLabels: false,
    type: BottomNavigationBarType.fixed,
    elevation: 10,
  );

  static BottomNavigationBarThemeData dark = BottomNavigationBarThemeData(
    backgroundColor: TColors.dark,
    selectedItemColor: Colors.white,
    unselectedItemColor: Colors.white,
    selectedIconTheme: IconThemeData(size: 28),
    unselectedIconTheme: IconThemeData(size: 22),
    showSelectedLabels: true,
    showUnselectedLabels: false,
    type: BottomNavigationBarType.fixed,
    elevation: 10,
  );
}
