import 'package:event_app/core/route/app_route.dart';
import 'package:event_app/core/route/route_name.dart';
import 'package:event_app/core/services/theme_service.dart';
import 'package:event_app/core/theme/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('--------User is currently signed out!-------------');
      } else {
        print('--------------User is signed in!----------------------');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeService(),
      child: Consumer<ThemeService>(
        builder: (context, themeService, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            initialRoute: RouteNames.splash,
            onGenerateRoute: AppRouter.generateRoute,
            themeMode: themeService.themeMode,
            theme: TAppTheme.lightAppTheme,
            darkTheme: TAppTheme.darkAppTheme,
            builder: EasyLoading.init(),
          );
        },
      ),
    );
  }
}
