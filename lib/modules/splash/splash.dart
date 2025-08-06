import 'package:event_app/core/constants/image_strings.dart';
import 'package:event_app/core/route/route_name.dart';
import 'package:event_app/core/services/app_data_services.dart';
import 'package:event_app/core/services/app_setting_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/constants/colors.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
    final user = FirebaseAuth.instance.currentUser;

    @override
    void initState() {
      super.initState();
      _loadInitialData();
    }

    void _loadInitialData() async {
      await Future.delayed(Duration(seconds: 1)); // Optional delay

      if (user != null) {
        await AppDataService.getcurrentUserData();
        await AppDataService.getcurrentLocation();

        Navigator.pushReplacementNamed(context, RouteNames.layout);
      } else {
        Navigator.pushReplacementNamed(context, RouteNames.onBoarding);
      }
    }


  @override
  Widget build(BuildContext context) {
     final appSetting=Provider.of<AppSettingProvider>(context);

    return Scaffold(
      backgroundColor:appSetting.isDarkMode?TColors.dark:  Color(0xFFEAF7FC),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(height: 100), 
          Column(
            children: [
              Center(
                child: Image.asset(
                  TImages.logo,
                  height: 136,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 24.0),
            child: Image.asset(
              TImages.buttonSplashscreen, 
              height: 214,
            ),
          ),
        ],
      ),
    );
  }
}
