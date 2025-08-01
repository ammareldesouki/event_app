import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:event_app/core/constants/colors.dart';
import 'package:event_app/core/models/event_model.dart';
import 'package:event_app/core/route/route_name.dart';
import 'package:event_app/core/services/app_data_services.dart';
import 'package:event_app/core/services/event_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';


class EventDetailsScreen extends StatefulWidget {
  final EventModel eventModel;

  EventDetailsScreen({super.key, required this.eventModel});

  @override
  State<EventDetailsScreen> createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {
  TimeOfDay? _timeController;


  Future<void> _selectData() async {
    DateTime? _picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(), // Allow current date
        lastDate: DateTime(2030));
    setState(() {
      widget.eventModel.dateTime != _picked;
    });
  }


  Future<void> _selecttime() async {
    TimeOfDay? _picked = await showTimePicker(
        context: context, initialTime: _timeController ?? TimeOfDay.now());

    setState(() {
      widget.eventModel.timeString != _picked.toString();
    });
  }


  bool toeEdit = false;

  @override
  Widget build(BuildContext context) {
    String month = DateFormat.MMMM().format(widget.eventModel.dateTime);

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(
          toeEdit ?
          "Event Details" : "Edit Event",
          style: Theme.of(
            context,
          ).textTheme.titleMedium!.copyWith(color: TColors.primary),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: TColors.primary),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                toeEdit = !toeEdit;
              });
            },
            icon: Icon(Icons.edit_outlined, color: TColors.primary),
          ),
          IconButton(
            onPressed: () {
              AwesomeDialog(
                context: context,
                dialogType: DialogType.question,
                animType: AnimType.rightSlide,
                headerAnimationLoop: true,
                title: 'Question',
                desc: 'Are you sure delete this event',

                btnOkOnPress: () {
                  EventFireBaseFireStore.deleteEvent(widget.eventModel.id);
                  Navigator.pushReplacementNamed(context, RouteNames.layout);
                },
              ).show();
            },

            icon: Icon(CupertinoIcons.trash_fill, color: Colors.red),
          ),
        ],
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            spacing: 10,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 200,

                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  image: DecorationImage(
                    image: AssetImage(widget.eventModel.eventImage),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              toeEdit == false ?
              Text(
                widget.eventModel.title,
                style: Theme
                    .of(
                  context,
                )
                    .textTheme
                    .titleLarge!
                    .copyWith(color: TColors.primary),
              ) :
              TextFormField(
                decoration: InputDecoration(
                    labelText: widget.eventModel.title,
                    labelStyle: Theme
                        .of(
                      context,
                    )
                        .textTheme
                        .titleLarge!
                        .copyWith(color: TColors.primary)

                ),
              ),


              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: TColors.grey)
                ),

                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    spacing: 8,
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: TColors.primary
                        ),
                        child: Icon(Icons.calendar_month, color: Colors.white,),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          toeEdit == false ?
                          Text("${widget.eventModel.dateTime
                              .day} ${month} ${widget.eventModel.dateTime
                              .year}",
                            style: Theme
                                .of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(color: TColors.primary),)
                              : InkWell(
                              onTap: () {
                                _selectData();
                              },
                              child: Text(" Tap to edit the date  ${widget
                                  .eventModel.dateTime.day} ${month} ${widget
                                  .eventModel.dateTime.year}", style: Theme
                                  .of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(color: TColors.primary),)),
                          toeEdit == false ?

                          Text("${widget.eventModel.timeString}", style: Theme
                              .of(context)
                              .textTheme
                              .titleMedium)
                              : InkWell(
                              onTap: () {
                                _selecttime();
                              },
                              child: Text("Tap to edit the date ${widget
                                  .eventModel.timeString}", style: Theme
                                  .of(context)
                                  .textTheme
                                  .titleMedium))

                        ],
                      )
                    ],
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: TColors.grey)
                ),

                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    spacing: 8,
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: TColors.primary
                        ),
                        child: Icon(Icons.location_searching_outlined,
                          color: Colors.white,),
                      ),
                      Text("Cairo , Egypt", style: Theme
                          .of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(color: TColors.primary),)
                    ],
                  ),
                ),
              ),

              Container(
                height: 360,
                child: GoogleMap(initialCameraPosition: CameraPosition(
                    zoom: 20, target: widget.eventModel.locationEvent),
                  mapType: MapType.normal,
                  zoomControlsEnabled: true,
                  markers: {
                    Marker(markerId: MarkerId(widget.eventModel.id.toString()),
                        position: widget.eventModel.locationEvent,
                        icon: BitmapDescriptor.defaultMarkerWithHue(
                            BitmapDescriptor.hueAzure))
                  },
                ),
              ),

              Text("Description", style: Theme
                  .of(context)
                  .textTheme
                  .titleLarge,),
              Text("${widget.eventModel.description}")
            ],
          ),
        ),
      ),
    );
  }
}
