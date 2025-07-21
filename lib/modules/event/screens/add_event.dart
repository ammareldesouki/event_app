import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_app/core/constants/colors.dart';
import 'package:event_app/core/constants/image_strings.dart';
import 'package:event_app/core/wedgits/cutsome_text_filed.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../home/wedgits/catagory_card.dart';
import '../catagoryList.dart';

class AddEventScreen extends StatefulWidget {
  @override
  State<AddEventScreen> createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {


  int selectedIndex = 0;
  TextEditingController _titeController = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TimeOfDay? _timeController;
  TextEditingController _categoryController = TextEditingController();
  GlobalKey _formkey = GlobalKey<FormState>();
  final user = FirebaseAuth.instance.currentUser;

  CollectionReference events = FirebaseFirestore.instance.collection('events');

  Future<void> addevent() {
    // Call the user's CollectionReference to add a new user
    return events
        .add({
      'title': _titeController.text,
      'date': _dateController.text,
      'time': _timeController.toString(),
      'description': _descriptionController.text,
      'userid': user?.uid,
      'catageory': Data.categories[selectedIndex].name,
    })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }



  Future<void> _selecttime() async {
    TimeOfDay? _picked = await showTimePicker(
        context: context, initialTime: _timeController ?? TimeOfDay.now());

    setState(() {
      _timeController = _picked;
    });
  }


  Future<void> _selectData() async {
    DateTime?_picked = await showDatePicker(

        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2025),
        lastDate: DateTime(2030));

    setState(() {
      _dateController.text = _picked.toString().split(" ")[0];
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
              Form(

                child: Column(
                  children: [
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
                            catagoryModel: category,
                            isSelected: selectedIndex == Data
                                .categories.indexOf(category),);
                        }).toList()

                    )),
                    SizedBox(height: 27,),

                    Text("Title", style: Theme
                        .of(context)
                        .textTheme
                        .bodyMedium,),
                    TCustomeTextFormField(
                      controller: _titeController,
                      hintText: "Event Title",
                      child: ImageIcon(AssetImage(TImages.noteIcon)),


                    ),

                    SizedBox(height: 25,),
                    Text("Description", style: Theme
                        .of(context)
                        .textTheme
                        .bodyMedium,),
                    TCustomeTextFormField(
                      controller: _descriptionController,

                      hintText: "Event Description",

                      maxLine: 4,

                    ),
                    Row(
                      children: [
                        Icon(Icons.calendar_month_outlined),
                        SizedBox(width: 10,),

                        Text("Event Date", style: Theme
                            .of(context)
                            .textTheme
                            .bodyMedium,),
                        Spacer(),
                        TextButton(onPressed: () {
                          _selectData();
                        },
                            child: Text(
                              _dateController.text != null ? "${_dateController
                                  .text}" : "Choose Date",
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
                        Text("Event Time", style: Theme
                            .of(context)
                            .textTheme
                            .bodyMedium,),
                        Spacer(),
                        TextButton(onPressed: () {
                          _selecttime();
                        },
                            child: Text(_timeController != null
                                ? "${_timeController
                                ?.hour} : ${_timeController?.minute}"
                                : "Choose Time",
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(color: TColors.primary),))
                      ],
                    ),
                    Text("Location", style: Theme
                        .of(context)
                        .textTheme
                        .bodyMedium,),
                    SizedBox(height: 8,),

                    ElevatedButton(onPressed: () {}, child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Row(
                        spacing: 8,
                        children: [
                          Image(image: AssetImage(TImages.location)),
                          Text(
                              "Choose Location", style: Theme
                              .of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(color: TColors.primary)
                          ),


                        ],

                      ),
                    ),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white),

                    ),
                    SizedBox(height: 16,),
                    Container(
                        width: double.infinity,
                        child: ElevatedButton(onPressed: () {
                          addevent();
                        }, child: Text("Create Event"))),
                  ],
                ),
              )

          
            ],
          ),
        ),
      ),

    );
  }
}
