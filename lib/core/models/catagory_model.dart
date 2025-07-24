import 'package:flutter/material.dart';

import '../../modules/event/catagoryList.dart';

class CategoryModel {

  final String name;
  final IconData icon;
  final String imagePath;


  CategoryModel({
    required this.name,
    required this.icon,
    required this.imagePath,
  });

  static CategoryModel getCategoryByName(String name) {
    return Data.categories.firstWhere(
          (cat) => cat.name == name,
      orElse: () =>
          CategoryModel(
            name: 'Unknown',
            icon: Icons.help,
            imagePath: '',
          ),
    );
  }
}


