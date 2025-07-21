import 'package:flutter/material.dart';

import 'models/catagory_model.dart';

abstract class Data {
  static final List<CategoryModel> categories = [
    CategoryModel(
      name: 'Sport',
      icon: Icons.sports_soccer,
      imagePath: 'assets/banners/sport.png',
    ),
    CategoryModel(
      name: 'Birthday',
      icon: Icons.cake,
      imagePath:
          'assets/banners/brithday.png', // consider renaming to "birthday.png"
    ),
    CategoryModel(
      name: 'Meeting',
      icon: Icons.meeting_room,
      imagePath:
          'assets/banners/meating.png', // consider renaming to "meeting.png"
    ),
    CategoryModel(
      name: 'Gaming',
      icon: Icons.videogame_asset,
      imagePath:
          'assets/banners/gyming.png', // consider renaming to "gaming.png"
    ),
    CategoryModel(
      name: 'Eating',
      icon: Icons.restaurant,
      imagePath: 'assets/banners/eating.png',
    ),
    CategoryModel(
      name: 'Holiday',
      icon: Icons.beach_access,
      imagePath: 'assets/banners/holiday.png',
    ),
    CategoryModel(
      name: 'Exhibition',
      icon: Icons.museum,
      imagePath: 'assets/banners/exhibition.png',
    ),
    CategoryModel(
      name: 'Workshop',
      icon: Icons.handyman,
      imagePath: 'assets/banners/workshop.png',
    ),
    CategoryModel(
      name: 'Book Club',
      icon: Icons.menu_book,
      imagePath: 'assets/banners/bookclub.png',
    ),
  ];
}
