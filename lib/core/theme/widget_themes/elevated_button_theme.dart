import 'package:flutter/material.dart';

import '../../constants/colors.dart';

class TElevatedButtonTheme {
  static final lightElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: TColors.buttonDisabled,
      backgroundColor: TColors.buttonPrimary,

      disabledForegroundColor: TColors.buttonDisabled,
      disabledBackgroundColor: TColors.buttonDisabled,
      side: const BorderSide(color: Colors.blue),
      padding: const EdgeInsets.symmetric(vertical: 18),
      textStyle: const TextStyle(
        fontSize: 16,
        color: Colors.white,
        fontWeight: FontWeight.w600,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  );


    static final darkElevatedButtonTheme = ElevatedButtonThemeData(
         style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: TColors.buttonDisabled,
      backgroundColor: TColors.buttonPrimary,

      disabledForegroundColor: TColors.buttonDisabled,
      disabledBackgroundColor: TColors.buttonDisabled,
      side: const BorderSide(color: Colors.blue),
      padding: const EdgeInsets.symmetric(vertical: 18),
      textStyle: const TextStyle(
        fontSize: 16,
        color: Colors.white,
        fontWeight: FontWeight.w600,
      ),

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  );
}
