import 'package:event_app/modules/home/wedgits/event_card.dart';
import 'package:event_app/modules/home/wedgits/home_header.dart';
import 'package:event_app/services/user_services.dart';
import 'package:flutter/material.dart';

import '../../authentication/models/user_model.dart';

class Homescreen extends StatefulWidget {
  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {

  UserModel? userModel;

  @override
  void initState() {
    _loadUserData();
    super.initState();
  }

  Future<void> _loadUserData() async {
    try {
      final user = await UserService.getCurrentUserData();
      setState(() {
        userModel = user;
      });
    } catch (e) {
      print('Error loading user data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            HomeHeader(Username: "${userModel?.name}",
              Useremail: '${userModel?.email}',),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  spacing: 10,
                  children: [
                    EventCard(),
                                        EventCard(),

                    EventCard(),
                    EventCard(),

                    EventCard(),
                    EventCard(),
                    EventCard(),

                  ],
                ),
              ),
            )


          ],
        ),
      ),
    );
  }
}

