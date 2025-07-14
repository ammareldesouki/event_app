import 'package:event_app/core/route/app_route.dart';
import 'package:event_app/core/route/route_name.dart';
import 'package:event_app/core/theme/theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      initialRoute: RouteNames.splash,
      onGenerateRoute: AppRouter.generateRoute,
      themeMode:ThemeMode.system,
      theme: TAppTheme.lightAppTheme,
      darkTheme: TAppTheme.darkAppTheme,
     
    );
  }
}

