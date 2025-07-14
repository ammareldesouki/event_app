import 'package:event_app/core/constants/image_strings.dart';
import 'package:event_app/core/route/route_name.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration(seconds: 3),
      () {
        Navigator.pushReplacementNamed(context, RouteNames.login);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEAF7FC),
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
