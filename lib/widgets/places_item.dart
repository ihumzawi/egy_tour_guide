import 'package:egy_tour_guide/widgets/my_text.dart';
import 'package:flutter/material.dart';

class PlacesItem extends StatelessWidget {
  final String id ;
  final String title ; 
  final String imageUrl ;
  final String goverBy ;

  
  void selectPlace() {}
  const PlacesItem({required this.id, required this.title, required this.imageUrl, required this.goverBy});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: selectPlace,
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
