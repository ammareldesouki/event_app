import 'package:flutter/material.dart';
import '../../constants/colors.dart';


class TAppbarTheme {
  


static const lightAppBarTheme=AppBarTheme(
elevation: 0,
centerTitle: false,
scrolledUnderElevation: 0,
backgroundColor: Colors. transparent,
surfaceTintColor: Colors. transparent,
iconTheme: IconThemeData(color: TColors.black, size: 24) ,
actionsIconTheme: IconThemeData(color: TColors.black, size: 24) ,

titleTextStyle: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600, color: TColors.black) ,
);
static const darkAppBarTheme=AppBarTheme(
elevation: 0,
centerTitle: false,
scrolledUnderElevation: 0,
backgroundColor: Colors. transparent,
surfaceTintColor: Colors. transparent,
iconTheme: IconThemeData(color: TColors.white, size: 24) ,
actionsIconTheme: IconThemeData(color: TColors.white, size: 24) ,

titleTextStyle: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600, color: TColors.white) ,
);
}