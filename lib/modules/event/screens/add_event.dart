import 'package:event_app/core/constants/colors.dart';
import 'package:event_app/core/constants/image_strings.dart';
import 'package:event_app/core/models/event_model.dart';
import 'package:event_app/core/wedgits/cutsome_text_filed.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../core/services/firbase/firestore/event_services.dart';
import '../../home/wedgits/catagory_card.dart';
import '../catagoryList.dart';

class AddEventScreen extends StatefulWidget {
  @override
  State<AddEventScreen> createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {


  int selectedIndex = 0;
  TextEditingController _titeController = TextEditingController();
  DateTime? _dateController;
  TextEditingController _descriptionController = TextEditingController();
  TimeOfDay? _timeController;

  // Removed _categoryController
  GlobalKey _formkey = GlobalKey<FormState>();
  final user = FirebaseAuth.instance.currentUser;






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
        firstDate: DateTime.now(), // Allow current date
        lastDate: DateTime(2030));
    setState(() {
      _dateController = _picked;
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
                              _dateController != null ? "${_dateController
                              }" : "Choose Date",
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
                          if (_dateController != null && _timeController !=
                              null) {
                            EventFireBaseFireStore.createNewEvent(
                                EventModel(
                                  id: 1,
                                  // Consider using a unique id in production
                                  title: _titeController.text,
                                  description: _descriptionController.text,
                                  dateTime: _dateController!,
                                  timeString: EventModel.timeOfDayToString(
                                      _timeController!),
                                  categoryName: Data.categories[selectedIndex]
                                      .name,
                                )
                            );
                          } else {
                            // Show error if date or time is not selected
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(
                                  'Please select both date and time.')),
                            );
                          }
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
