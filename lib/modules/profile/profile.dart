import 'package:event_app/core/constants/colors.dart';
import 'package:event_app/core/route/route_name.dart';
import 'package:event_app/core/services/auth_services.dart';
import 'package:event_app/core/services/user_services.dart';
import 'package:event_app/modules/authentication/models/user_model.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  UserModel? userData;
  bool isLoading = true;
  bool isRefreshing = false;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    try {
      final user = await UserService.getCurrentUserData();
      setState(() {
        userData = user;
        isLoading = false;
        isRefreshing = false;
      });
    } catch (e) {
      print('Error loading user data: $e');
      setState(() {
        isLoading = false;
        isRefreshing = false;
      });
    }
  }

  Future<void> _refreshUserData() async {
    setState(() {
      isRefreshing = true;
    });
    await _loadUserData();
  }

  @override
  Widget build(BuildContext context) {
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
                        children: [
                          // Profile Image
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
                            child: userData?.photoUrl != null
                                ? ClipRRect(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(50),
                                topRight: Radius.circular(50),
                                bottomRight: Radius.circular(50),
                              ),
                              child: Image.network(
                                userData!.photoUrl!,
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
                                    userData?.name ?? "User",
                                    style: Theme
                                        .of(context)
                                        .textTheme
                                        .titleLarge!
                                        .copyWith(color: Colors.white),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    userData?.email ?? "No email",
                                    style: Theme
                                        .of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(color: Colors.white),
                                  ),
                                  SizedBox(height: 8),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      userData?.role?.toUpperCase() ?? "USER",
                                      style: Theme
                                          .of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(color: Colors.white),
                                    ),
                                  ),
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
                Container(
                  height: 56,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: TColors.TextFormField, width: 1),
                  ),
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: DropdownButton(
                      isExpanded: true,
                      hint: Text(
                        "Arabic",
                        style: Theme
                            .of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(color: TColors.primary),
                      ),
                      items: [
                        DropdownMenuItem(
                          child: Text(
                            "English",
                            style: Theme
                                .of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(color: TColors.primary),
                          ),
                          value: "English",
                        ),
                        DropdownMenuItem(
                          child: Text(
                            "Arabic",
                            style: Theme
                                .of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(color: TColors.primary),
                          ),
                          value: "Arabic",
                        ),
                      ],
                      onChanged: (value) => value,
                    ),
                  ),
                ),

                SizedBox(height: 16),
                Text("Theme", style: Theme
                    .of(context)
                    .textTheme
                    .titleMedium),
                Container(
                  height: 56,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: TColors.TextFormField, width: 1),
                  ),
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: DropdownButton(
                      isExpanded: true,
                      hint: Text(
                        "Dark",
                        style: Theme
                            .of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(color: TColors.primary),
                      ),
                      items: [
                        DropdownMenuItem(
                          child: Text(
                            "Dark",
                            style: Theme
                                .of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(color: TColors.primary),
                          ),
                          value: "Dark",
                        ),
                        DropdownMenuItem(
                          child: Text(
                            "Light",
                            style: Theme
                                .of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(color: TColors.primary),
                          ),
                          value: "Light",
                        ),
                      ],
                      onChanged: (value) => value,
                    ),
                  ),
                ),

                // User ID Display (for debugging)

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
