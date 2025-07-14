
import 'package:event_app/core/theme/widget_themes/appbar_theme.dart';
import 'package:event_app/core/theme/widget_themes/bottom_sheet_theme.dart';
import 'package:event_app/core/theme/widget_themes/checkbox_theme.dart';
import 'package:event_app/core/theme/widget_themes/elevated_button_theme.dart';
import 'package:event_app/core/theme/widget_themes/text_field_theme.dart';
import 'package:event_app/core/theme/widget_themes/text_theme.dart';
import 'package:flutter/material.dart';
import '../constants/colors.dart';


class TAppTheme {
  TAppTheme._();
  static ThemeData lightAppTheme = ThemeData(
 useMaterial3: true,
 
 scaffoldBackgroundColor: TColors.light,
 fontFamily: 'Inter',
 brightness: Brightness.light,

 textTheme:TTextTheme.lightTextTheme,
elevatedButtonTheme: TElevatedButtonTheme.lightElevatedButtonTheme,
inputDecorationTheme: TTextFormFieldTheme.lightInputDecorationTheme,
appBarTheme: TAppbarTheme.lightAppBarTheme,
checkboxTheme: TCheckboxTheme.lightCheckboxTheme,
bottomSheetTheme: TBottomSheetTheme.lightBottomSheetTheme






  );

  static ThemeData darkAppTheme = ThemeData(
     useMaterial3: true,
 scaffoldBackgroundColor: TColors.dark,
 fontFamily: 'Inter',
 brightness: Brightness.dark,
 primaryColor: TColors.primary,
 textTheme:TTextTheme.darkTextTheme,
 elevatedButtonTheme: TElevatedButtonTheme.darkElevatedButtonTheme,
 inputDecorationTheme: TTextFormFieldTheme.darkInputDecorationTheme,
 appBarTheme:  TAppbarTheme.darkAppBarTheme,
 checkboxTheme: TCheckboxTheme.darkCheckboxTheme,
 bottomSheetTheme:TBottomSheetTheme.darkBottomSheetTheme



  );
}
