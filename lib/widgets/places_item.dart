import 'package:egy_tour_guide/screens/covermorate/governorate_details.dart';
import 'package:egy_tour_guide/widgets/my_text.dart';
import 'package:flutter/material.dart';

class PlacesItem extends StatelessWidget {
  final String id ;
  final String title ; 
  final String imageUrl ;
  final String des;
  final String placeId;
  final String latLong;
final String activitys;
  void selectPlace(BuildContext context) {
   
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => GovernorateDetails(
          categoryTitel: title,
          categoryId: id, des: des, imageUrl: imageUrl,
          placeId: placeId, latLong: latLong, activitys:activitys ,
        ),
        
      ),
    );
  }
  // ignore: use_key_in_widget_constructors
  const PlacesItem({required this.id, required this.title, required this.imageUrl, required this.des,
   required this.placeId, required this.latLong, required this.activitys,
   });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectPlace(context),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 7,
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius:const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  child: Image.network(imageUrl, height: 250,width: double.infinity,
                  fit: BoxFit.cover,
                  ),

                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: MyText(title: title),
            )
          ],
        ),
      ),
    );
  }
}
