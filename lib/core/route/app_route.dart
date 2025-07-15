import 'package:event_app/core/route/route_name.dart';
import 'package:event_app/layout.dart';
import 'package:event_app/modules/authentication/screens/forget_password.dart';
import 'package:event_app/modules/authentication/screens/login.dart';
import 'package:event_app/modules/authentication/screens/register.dart';
import 'package:event_app/modules/home/screens/home.dart';
import 'package:event_app/modules/splash/splash.dart';
import 'package:flutter/material.dart';


class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.splash:
        return MaterialPageRoute(builder: (_) => SplashScreen(),settings: settings);
        case RouteNames.login:
        return MaterialPageRoute(builder: (_) => LoginScreen(),settings: settings);
        case RouteNames.register:
        return MaterialPageRoute(builder: (_) => RegisterScreen(),settings: settings);
        case RouteNames.forgetPassword:
                return MaterialPageRoute(builder: (_) => ForgetPassword(),settings: settings);
        case RouteNames.home:
                        return MaterialPageRoute(builder: (_) => Homescreen(),settings: settings);
        case RouteNames.layout:   
                                return MaterialPageRoute(builder: (_) => Layout(),settings: settings);
             


  
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}