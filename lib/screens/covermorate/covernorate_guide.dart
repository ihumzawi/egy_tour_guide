import 'package:egy_tour_guide/widgets/places_item.dart';
import 'package:flutter/material.dart';
import 'package:egy_tour_guide/models/trip.dart';
class CovernorateGuide extends StatelessWidget {
  

static const covernorateRoute = '/covernorateGuide';

  @override
  Widget build(BuildContext context) {
    final Map routeArg = ModalRoute.of(context)!.settings.arguments as Map<String ,String> ;
    final categoryId = routeArg['id'];
    final categoryTitle = routeArg['title'];
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title:  Text("المزارات المتوفرة داخل"+' '+categoryTitle),

      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: ((context, index) {
          return PlacesItem(goverBy: "الجيزة",
          id: "لالالا",
          imageUrl: 'https://polarsteps.s3.amazonaws.com/u_70815/1640bbeb-372f-4dbd-b857-e603097c0324_big-thumbnail023149728121365576Pyramid+of+Khufu.jpg',
          title: 'اهرامات الجيزة',
          ) ;
        }),
      ),
    
    );
  }
}