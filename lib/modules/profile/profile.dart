import 'package:event_app/core/constants/colors.dart';
import 'package:event_app/core/route/route_name.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
                          Container(
                            height: 124,
                            width: 124,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                // topLeft: Radius.circular(25),
                                bottomLeft: Radius.circular(50),
                                topRight: Radius.circular(50),
                                bottomRight: Radius.circular(50),
                              ),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "AmmarMohmed",
                                style: Theme.of(context).textTheme.titleLarge!
                                    .copyWith(color: Colors.white),
                              ),
                              Text(
                                "ammareldesouki130@gmail.com",
                                style: Theme.of(context).textTheme.titleMedium!
                                    .copyWith(color: Colors.white),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: Column(
              spacing: 10,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Language",
                  style: Theme.of(context).textTheme.titleMedium,
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
                        style: Theme.of(context).textTheme.titleMedium!
                            .copyWith(color: TColors.primary),
                      ),
                      items: [
                        DropdownMenuItem(
                          child: Text(
                            "English",
                            style: Theme.of(context).textTheme.titleMedium!
                                .copyWith(color: TColors.primary),
                          ),
                          value: "English",
                        ),
                        DropdownMenuItem(
                          child: Text(
                            "Arabic",
                            style: Theme.of(context).textTheme.titleMedium!
                                .copyWith(color: TColors.primary),
                          ),
                          value: "Arabic",
                        ),
                      ],
                      onChanged: (value) => value,
                    ),
                  ),
                ),

                Text("Theme", style: Theme.of(context).textTheme.titleMedium),
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
                        style: Theme.of(context).textTheme.titleMedium!
                            .copyWith(color: TColors.primary),
                      ),
                      items: [
                        DropdownMenuItem(
                          child: Text(
                            "Dark",
                            style: Theme.of(context).textTheme.titleMedium!
                                .copyWith(color: TColors.primary),
                          ),
                          value: "Dark",
                        ),
                        DropdownMenuItem(
                          child: Text(
                            "Light",
                            style: Theme.of(context).textTheme.titleMedium!
                                .copyWith(color: TColors.primary),
                          ),
                          value: "Light",
                        ),
                      ],
                      onChanged: (value) => value,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ElevatedButton(
          onPressed: () async {
            final GoogleSignIn googleSignIn = GoogleSignIn();
            googleSignIn.disconnect();
            await FirebaseAuth.instance.signOut();
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
                  style: Theme.of(
                    context,
                  ).textTheme.titleMedium!.copyWith(color: Colors.white),
                ),
              ],
            ),
          ),
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
        ),
      ),
    );
  }
}
