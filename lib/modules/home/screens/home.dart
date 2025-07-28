import 'package:event_app/core/services/app_data_services.dart';
import 'package:event_app/modules/home/wedgits/event_card.dart';
import 'package:event_app/modules/home/wedgits/home_header.dart';
import 'package:flutter/material.dart';

class Homescreen extends StatefulWidget {
  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {




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
            HomeHeader(),
            Padding(
              padding: const EdgeInsets.all(16.0),

              child: ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),

                scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    return EventCard(eventModel: AppDataService.events[index],);
                  }
                  ,
                  separatorBuilder: (context, index) => SizedBox(height: 10,),
                  itemCount: AppDataService.events.length
                ),
              ),
          ],
        ),
      ),
    );
  }
}

