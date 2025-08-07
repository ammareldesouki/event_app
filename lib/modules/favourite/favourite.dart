import 'package:event_app/core/services/app_data_services.dart';
import 'package:event_app/core/services/event_services.dart';
import 'package:event_app/core/wedgits/cutsome_text_filed.dart';
import 'package:flutter/material.dart';

import '../../core/constants/colors.dart';
import '../home/wedgits/event_card.dart';

class FavouriteScreen extends StatefulWidget {
  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchText = "";

  @override
  void initState() {
    super.initState();

    // Listen to search field changes
    _searchController.addListener(() {
      setState(() {
        _searchText = _searchController.text.trim();
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // 🔍 Search TextField
              TextFormField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: "Search for Event",
                  hintStyle: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: TColors.primary),
                  prefixIcon: Icon(Icons.search, color: TColors.primary),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(width: 2, color: TColors.primary),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(width: 2, color: TColors.primary),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(width: 2, color: TColors.primary),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // 📦 Events List
              Expanded(
                child: StreamBuilder(
                  stream: _searchText.isEmpty
                      ? EventFireBaseFireStore.getStreemeventFavouritList(AppDataService.currentUserData?.uid??"")
                      : EventFireBaseFireStore.getStreemeventSearchFavouritList(_searchText),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return Center(child: Text('No events found'));
                    }

                    final eventList = snapshot.data!.docs.map((doc) => doc.data()).toList();

                    return ListView.separated(
                      itemCount: eventList.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 10),
                      itemBuilder: (context, index) {
                        return EventCard(eventModel: eventList[index]);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
