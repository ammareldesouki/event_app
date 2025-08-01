import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_app/core/services/app_data_services.dart';
import 'package:event_app/core/services/event_services.dart';
import 'package:event_app/modules/home/wedgits/event_card.dart';
import 'package:event_app/modules/home/wedgits/home_header.dart';
import 'package:flutter/material.dart';

import '../../event/catagoryList.dart';

class Homescreen extends StatefulWidget {
  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {

  int selectindex = 0;

  void updataSelected(int index) {
    setState(() {
      selectindex = index;
    });
  }




  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            HomeHeader(
                selectIndex: selectindex, onChange: updataSelected),
            StreamBuilder(
              stream: selectindex == 0 ? EventFireBaseFireStore
                  .getStreemeventList() : EventFireBaseFireStore
                  .getStreemeventtListByCategory(
                  CategoryName: Data.categories[selectindex].name),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(child: Text('No events found'));
                }

                // Convert snapshot to List<EventModel>
                final eventList = snapshot.data!
                    .docs
                    .map((doc) => doc.data())
                    .toList();

                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      return EventCard(eventModel: eventList[index]);
                    },
                    separatorBuilder: (context, index) => SizedBox(height: 10),
                    itemCount: eventList.length,
                  ),
                );
              },
            )

          ],
        ),
      ),
    );
  }
}

