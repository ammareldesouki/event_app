import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_app/core/route/app_route.dart';
import 'package:event_app/core/route/route_name.dart';
import 'package:event_app/core/services/app_setting_provider.dart';
import 'package:event_app/core/theme/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'core/services/local_storge_services.dart';
import 'firebase_options.dart';
import 'l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await LocalStorgeServices.init(); // Fixed typo

  // Preload settings before running the app
  final appSettingProvider = AppSettingProvider();
  await appSettingProvider.loadSettings();

  runApp(MyApp(appSettingProvider: appSettingProvider));
}

class MyApp extends StatelessWidget {
  final AppSettingProvider appSettingProvider;

  const MyApp({super.key, required this.appSettingProvider});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: appSettingProvider,
      child: Consumer<AppSettingProvider>(
        builder: (context, provider, child) {
          return MaterialApp(
            locale: provider.locale,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            initialRoute: RouteNames.splash,
            onGenerateRoute: AppRouter.generateRoute,
            themeMode: provider.themeMode,
            theme: TAppTheme.lightAppTheme,
            darkTheme: TAppTheme.darkAppTheme,
            builder: EasyLoading.init(),
          );
        },
      ),
    );
  }
}