import 'package:event_app/core/constants/colors.dart';
import 'package:event_app/core/constants/image_strings.dart';
import 'package:event_app/core/wedgits/cutsome_text_filed.dart';
import 'package:flutter/material.dart';

class AddEventScreen extends StatefulWidget {
  @override
  State<AddEventScreen> createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
      int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
       final List<Map<String, dynamic>> categories = [
    {'label': 'All', 'icon': Icons.circle},
    {'label': 'Sport', 'icon': Icons.directions_bike},
    {'label': 'Birthday', 'icon': Icons.cake},
  
  ];
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
                        image:DecorationImage(image:AssetImage(TImages.brithdayImage),fit: BoxFit.cover )
                ),
                   
              ),
               SingleChildScrollView(
                scrollDirection: Axis.horizontal,
              
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(categories.length, (index) {
                        final isSelected = selectedIndex == index;
                        return Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: ChoiceChip(
                            label: Text(
                              categories[index]['label'],
                              style: TextStyle(
                                color: isSelected ? TColors.primary : Colors.white,
                              ),
                            ),
                            avatar: Icon(
                              categories[index]['icon'],
                              size: 18,
                              color: isSelected ? TColors.primary : Colors.white,
                            ),
                            selected: isSelected,
                            selectedColor: Colors.white,
                            backgroundColor: TColors.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side: BorderSide(color: TColors.primary),
                            ),
                            onSelected: (selected) {
                              setState(() {
                                selectedIndex = index;
                              });
                            },
                ),
          
                        );       
                  }, 
                  ),              
          
          ),
                  ),
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
                TextButton(onPressed: (){}, child: Text("Choose Date",style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: TColors.primary),))
              ],
            ),
                Row(
              children: [
                Icon(Icons.watch_later_outlined),
                SizedBox(width: 10,),
                Text("Event Time",style: Theme.of(context).textTheme.bodyMedium,),
                Spacer(),
                TextButton(onPressed: (){}, child: Text("Choose Time",style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: TColors.primary),))
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
