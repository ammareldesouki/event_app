import 'package:event_app/core/constants/colors.dart';
import 'package:event_app/core/constants/image_strings.dart';
import 'package:event_app/core/wedgits/cutsome_text_filed.dart';
import 'package:flutter/material.dart';

import '../../home/wedgits/catagory_card.dart';
import '../catagoryList.dart';

class AddEventScreen extends StatefulWidget {
  @override
  State<AddEventScreen> createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
  int selectedIndex = 0;
  DateTime? _SelectDate;
  TimeOfDay? _SelectedTime;

  Future<void> _selecttime() async {
    TimeOfDay? _picked = await showTimePicker(
        context: context, initialTime: _SelectedTime ?? TimeOfDay.now());

    setState(() {
      _SelectedTime = _picked;
    });
  }


  Future<void> _selectData() async {
    DateTime?_picked = await showDatePicker(

        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2025),
        lastDate: DateTime(2030));

    setState(() {
      _SelectDate = _picked;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Create Event',style: Theme.of(context).textTheme.titleLarge!.copyWith(color: TColors.primary),),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            spacing: 10,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
               height: 200,
                        
                        
                decoration: BoxDecoration(
                  color: Colors.white,
                   borderRadius: BorderRadius.circular(16),
                    image: DecorationImage(image: AssetImage(
                        Data.categories[selectedIndex].imagePath),
                        fit: BoxFit.cover)
                ),
                   
              ),
              DefaultTabController(
                  length: Data.categories.length, child: TabBar(
                  onTap: (index) {
                    selectedIndex = index;
                    setState(() {

                    });
                  },

                  isScrollable: true,
                  tabAlignment: TabAlignment.start,
                  indicatorColor: Colors.white,
                  dividerColor: Colors.transparent,
                  indicator:
                  BoxDecoration(),


                  tabs: Data.categories.map((category) {
                    return CatagoryCard(
                      catagoryModel: category, isSelected: selectedIndex == Data
                        .categories.indexOf(category),);
                  }).toList()

              )),
           SizedBox(height: 27,),

          Text( "Title",style: Theme.of(context).textTheme.bodyMedium,),
           TCustomeTextFormField(
            hintText: "Event Title",
            child: ImageIcon(AssetImage(TImages.noteIcon)),



        
           ),

           SizedBox(height: 25,),
           Text("Description",style: Theme.of(context).textTheme.bodyMedium,),
           TCustomeTextFormField(

          
            hintText: "Event Description",
            
            maxLine: 4,
            
            ),
            Row(
              children: [
                Icon(Icons.calendar_month_outlined),
                                SizedBox(width: 10,),

                Text("Event Date",style: Theme.of(context).textTheme.bodyMedium,),
                Spacer(),
                TextButton(onPressed: () {
                  _selectData();
                },
                    child: Text(
                      _SelectDate != null ? "${_SelectDate!.day}/${_SelectDate!
                          .month}/${_SelectDate!.year}" : "Choose Date",
                      style: Theme
                          .of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: TColors.primary),))
              ],
            ),
                Row(
              children: [
                Icon(Icons.watch_later_outlined),
                SizedBox(width: 10,),
                Text("Event Time",style: Theme.of(context).textTheme.bodyMedium,),
                Spacer(),
                TextButton(onPressed: () {
                  _selecttime();
                },
                    child: Text(_SelectedTime != null ? "${_SelectedTime
                        ?.hour} : ${_SelectedTime?.minute}" : "Choose Time",
                      style: Theme
                          .of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: TColors.primary),))
              ],
            ),
            Text("Location",style: Theme.of(context).textTheme.bodyMedium,),
            SizedBox(height: 8,),

            ElevatedButton(onPressed: (){}, child: Padding(
              padding: const EdgeInsets.symmetric(horizontal:  10.0),
              child: Row(
                spacing: 8,
                children: [
                  Image(image: AssetImage(TImages.location)),
                  Text(
                    "Choose Location",style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: TColors.primary)
                  ),
                  
                 
                ],
                
              ),
            ),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.white),

            ),
                        SizedBox(height: 16,),
                        Container(
                          width: double.infinity,
                          child: ElevatedButton(onPressed: (){}, child: Text("Create Event")))

          
            ],
          ),
        ),
      ),

    );
  }
}
