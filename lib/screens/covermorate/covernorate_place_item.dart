import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:egy_tour_guide/widgets/places_item.dart';
import 'package:egy_tour_guide/widgets/widgets.dart';
import 'package:flutter/material.dart';

import '../../taps.dart';

class CovernoratePlaceItem extends StatefulWidget {
  static const covernorateRoute = '/covernorateGuide';
  final String categoryId;
  final String categoryTitel;

  // ignore: use_key_in_widget_constructors
  const CovernoratePlaceItem({
    required this.categoryId,
    required this.categoryTitel,
  });

  @override
  State<CovernoratePlaceItem> createState() => _CovernoratePlaceItemState();
}

class _CovernoratePlaceItemState extends State<CovernoratePlaceItem> {

  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("المزارات المتوفرة داخل" " " + widget.categoryTitel),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.of(context)
                  .pushReplacementNamed(TapsScreen.tapsRoute);
            },
          ),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('places')
              .where('gid', isEqualTo: widget.categoryId)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.data!.docs.isNotEmpty) {
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: ((context, index) {
                    return PlacesItem(
                      id: snapshot.data!.docs[index]['gid'],
                      imageUrl: snapshot.data!.docs[index]['imageUrl'],
                      title: snapshot.data!.docs[index]['name'],
                      des:snapshot.data!.docs[index]['des'] ,
                      placeId:snapshot.data!.docs[index]['placeID'], 
                      latLong: snapshot.data!.docs[index]['latLong'],
                       activitys: snapshot.data!.docs[index]['placeActivitys'] ,
                    );
                  }),
                );
              } else {
                return const Center(
                  child: MyText(title: 'لا يوجد اماكن متوفرة'),
                );
              }
            } else {
              return const Center(
                child: MyText(title: 'لقد حدث خطأ'),
              );
            }
          },
        ));
  }
}
