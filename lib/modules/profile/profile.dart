import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:event_app/core/constants/colors.dart';
import 'package:event_app/core/route/route_name.dart';
import 'package:event_app/core/services/app_data_services.dart';
import 'package:event_app/core/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/services/app_setting_provider.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isLoading = false;
  bool isRefreshing = false;

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    List<String>_Language = ["Englisht", "عربي",];
    List <String>_Theme = ["Light", "Dark"];
    final appSetting = Provider.of<AppSettingProvider>(context);
    return Scaffold(

      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
        children: [
          SizedBox(
            height: 210,
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 200,
                    decoration: BoxDecoration(
                      color: TColors.primary,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(64),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        spacing: 10,
                        children: [
                          Container(
                            height: 124,
                            width: 124,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(50),
                                topRight: Radius.circular(50),
                                bottomRight: Radius.circular(50),
                              ),
                            ),
                            child: AppDataService.currentUserData!.photoUrl !=
                                null
                                ? ClipRRect(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(50),
                                topRight: Radius.circular(50),
                                bottomRight: Radius.circular(50),
                              ),
                              child: Image.network(
                                AppDataService.currentUserData?.photoUrl ??
                                    "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png",
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Icon(
                                    Icons.person,
                                    size: 60,
                                    color: TColors.primary,
                                  );
                                },
                              ),
                            )
                                : Icon(
                              Icons.person,
                              size: 60,
                              color: TColors.primary,
                            ),
                          ),
                          // User Info
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    AppDataService.currentUserData?.name ??
                                        "User",
                                    style: Theme
                                        .of(context)
                                        .textTheme
                                        .titleLarge!
                                        .copyWith(color: Colors.white),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    AppDataService.currentUserData?.email ??
                                        "No email",
                                    style: Theme
                                        .of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(color: Colors.white),
                                  ),
                                  SizedBox(height: 8),

                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Settings Section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: Column(
              spacing: 10,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Language",
                  style: Theme
                      .of(context)
                      .textTheme
                      .titleMedium,
                ),
                CustomDropdown<String>(
                  hintText: 'Select Languge',

                  items: _Language,
                  decoration: CustomDropdownDecoration(
                    listItemStyle: Theme
                        .of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(color: TColors.primary),
                    closedSuffixIcon: Icon(
                      Icons.arrow_drop_down, size: 30, color: TColors.primary,),
                    headerStyle: Theme
                        .of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(color: TColors.primary),
                  ),

                  onChanged: (value) {},
                ),

                SizedBox(height: 16),
                Text("Theme", style: Theme
                    .of(context)
                    .textTheme
                    .titleMedium),
                CustomDropdown<String>(
                  hintText: 'Theme',

                  decoration: CustomDropdownDecoration(
                    listItemStyle: Theme
                        .of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(color: TColors.primary),
                    closedSuffixIcon: Icon(
                      Icons.arrow_drop_down, size: 30, color: TColors.primary,),
                    headerStyle: Theme
                        .of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(color: TColors.primary),
                  ),
                  items: _Theme,

                  onChanged: (value) {
                    if (value == " Dark")
                      appSetting.setThemeMode(ThemeMode.dark);
                    else
                      appSetting.setThemeMode(ThemeMode.light);
                    appSetting.toggleTheme();
                  },
                )

              ],
            ),
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ElevatedButton(
          onPressed: () async {
            await AuthService.disconnect();
            await AuthService.signOut();
            Navigator.pushReplacementNamed(context, RouteNames.login);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Icon(Icons.exit_to_app),
                SizedBox(width: 10),
                Text(
                  "Logout",
                  style: Theme
                      .of(
                    context,
                  )
                      .textTheme
                      .titleMedium!
                      .copyWith(color: Colors.white),
                ),
              ],
            ),
          ),
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.noAnimation,
    );
  }
}
