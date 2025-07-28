import 'package:event_app/core/services/firbase/firestore/event_services.dart';
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
  static List data = [];

  _getData() async {
    data = await EventFireBaseFireStore.getEventList();
    setState(() {

    });

  }

  UserModel? userModel;

  @override
  void initState() {
    _loadUserData();
    _getData();
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

              child: ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),

                scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    return EventCard(eventModel: data[index],);
                  }
                  ,
                  separatorBuilder: (context, index) => SizedBox(height: 10,),
                  itemCount: data.length
                ),
              ),
          ],
        ),
      ),
    );
  }
}

