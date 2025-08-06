import 'package:event_app/core/constants/colors.dart';
import 'package:event_app/core/constants/image_strings.dart';
import 'package:event_app/core/models/event_model.dart';
import 'package:event_app/core/route/route_name.dart';
import 'package:event_app/core/services/app_data_services.dart';
import 'package:event_app/core/wedgits/cutsome_text_filed.dart';
import 'package:event_app/modules/event/widgets/create_event_catagory_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../../../core/services/app_setting_provider.dart';
import '../../../core/services/event_services.dart';
import '../catagoryList.dart';

class AddEventScreen extends StatefulWidget {
  const AddEventScreen({super.key});

  @override
  State<AddEventScreen> createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
  int selectedIndex = 0;
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  DateTime? _dateController;
  TimeOfDay? _timeController;
  GoogleMapController? _mapController;
  LatLng? _currentPosition = AppDataService.currentLocation;
  LatLng? _eventLocation;
  bool _isMapView = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _mapController?.dispose();
    super.dispose();
  }


  Future<void> _selectTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _timeController ?? TimeOfDay.now(),
    );
    if (picked != null && mounted) {
      setState(() {
        _timeController = picked;
      });
    }
  }

  Future<void> _selectDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );
    if (picked != null && mounted) {
      setState(() {
        _dateController = picked;
      });
    }
  }

  void _toggleMapView() {
    setState(() {
      _isMapView = !_isMapView;
    });
  }

  String? _validateTitle(String? value) {
    if (value == null || value
        .trim()
        .isEmpty) {
      return 'Title cannot be empty';
    }
    return null;
  }

  String? _validateDescription(String? value) {
    if (value == null || value
        .trim()
        .isEmpty) {
      return 'Description cannot be empty';
    }
    return null;
  }

  Future<void> _createEvent() async {
    if (_formKey.currentState?.validate() != true) {
      return;
    }

    if (_dateController == null || _timeController == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select both date and time')),
      );
      return;
    }

    if (_eventLocation == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select an event location')),
      );
      return;
    }

    try {
      EasyLoading.show(status: 'Creating event...');
      await EventFireBaseFireStore.createNewEvent(
          EventModel(
              title: _titleController.text,
              // Consider using a unique id in production
              locationEvent: _eventLocation ?? LatLng(52.2165157, 52.2165157)
              ,
              description: _descriptionController.text,
              dateTime: _dateController!,
              timeString: EventModel.timeOfDayToString(
                  _timeController!),
              categoryName: Data.categories[selectedIndex]
                  .name,
              eventImage: Data.categories[selectedIndex]
                  .imagePath
          )
      );
      EasyLoading.showSuccess('Event created successfully');

    } catch (e) {
      EasyLoading.showError('Failed to create event: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final appSetting = Provider.of<AppSettingProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Create Event',
          style: Theme
              .of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: TColors.primary),
        ),
        centerTitle: true,
      ),
      body: _isMapView
          ? GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
          target: _currentPosition ?? const LatLng(52.2165157, 6.9437819),
          zoom: 15,
        ),
        onTap: (position) {
          setState(() {
            _eventLocation = position;
          });
        },
        markers: {
          if (_eventLocation != null)
            Marker(
              markerId: const MarkerId('eventLocation'),
              position: _eventLocation!,
                icon: BitmapDescriptor.defaultMarkerWithHue(
                    BitmapDescriptor.hueAzure)
            ),
          if (_currentPosition != null)
            Marker(
              markerId: const MarkerId('currentLocation'),
              position: _currentPosition!,

            ),
        },
        onMapCreated: (controller) {
          _mapController = controller;
          if (_currentPosition != null) {
            controller.animateCamera(
              CameraUpdate.newLatLngZoom(_currentPosition!, 15),
            );
          }
        },
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
      )
          : SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    image: DecorationImage(
                      image: AssetImage(
                          Data.categories[selectedIndex].imagePath),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                DefaultTabController(
                  length: Data.categories.length,
                  child: TabBar(
                    onTap: (index) {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                    isScrollable: true,
                    tabAlignment: TabAlignment.start,
                    indicatorColor: Colors.transparent,
                    dividerColor: Colors.transparent,
                    tabs: Data.categories
                        .asMap()
                        .entries
                        .map((entry) =>
                        CreateEventCatagoryCard(
                          catagoryModel: entry.value,
                          isSelected: selectedIndex == entry.key,
                        ))
                        .toList(),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Title',
                  style: Theme
                      .of(context)
                      .textTheme
                      .bodyMedium,
                ),
                TCustomeTextFormField(
                  validator: _validateTitle,
                  controller: _titleController,
                  hintText: 'Event Title',
                  child: const ImageIcon(AssetImage(TImages.noteIcon)),
                ),
                const SizedBox(height: 8),
                Text(
                  'Description',
                  style: Theme
                      .of(context)
                      .textTheme
                      .bodyMedium,
                ),
                TCustomeTextFormField(
                  validator: _validateDescription,
                  controller: _descriptionController,
                  hintText: 'Event Description',
                  maxLine: 4,

                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    const Icon(Icons.calendar_month_outlined),
                    const SizedBox(width: 10),
                    Text(
                      'Event Date',
                      style: Theme
                          .of(context)
                          .textTheme
                          .bodyMedium,
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: _selectDate,
                      child: Text(
                        _dateController != null
                            ? _dateController!.toString().split(' ')[0]
                            : 'Choose Date',
                        style: Theme
                            .of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: TColors.primary),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.watch_later_outlined),
                    const SizedBox(width: 10),
                    Text(
                      'Event Time',
                      style: Theme
                          .of(context)
                          .textTheme
                          .bodyMedium,
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: _selectTime,
                      child: Text(
                        _timeController != null
                            ? _timeController!.format(context)
                            : 'Choose Time',
                        style: Theme
                            .of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: TColors.primary),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  'Location',
                  style: Theme
                      .of(context)
                      .textTheme
                      .bodyMedium,
                ),
                ElevatedButton(
                  onPressed: _toggleMapView,
                  style: ElevatedButton.styleFrom(
                      backgroundColor: appSetting.isDarkMode?TColors.dark: Colors.white),
                  child: Row(

                    children: [
                      Image(image: AssetImage(TImages.location)),
                      const SizedBox(width: 8),
                      Text(
                        _eventLocation != null
                            ? 'Location Selected'
                            : 'Choose Location',
                        style: Theme
                            .of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: TColors.primary),
                      ),
                    ],
                  ),
                ),


              ],
            ),

          ),
        ),

      ),
      floatingActionButton: _isMapView ?
      Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ElevatedButton(
          onPressed: () {
            _isMapView = !_isMapView;
            setState(() {

            });
          },
          child: Text('Tap to Select Location'),
        ),
      ) :
      Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ElevatedButton(
          onPressed: () {
            _createEvent();


          },
          child: Text('Create Event'),
        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}