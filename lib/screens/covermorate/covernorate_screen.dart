import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:egy_tour_guide/models/models.dart';
import 'package:egy_tour_guide/widgets/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../app_data.dart';

class CovernorateScreen extends StatefulWidget {
  const CovernorateScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<CovernorateScreen> createState() => _CovernorateScreenState();
}

class _CovernorateScreenState extends State<CovernorateScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

        // get data in firebase
        body: StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('gover').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.data!.docs.isNotEmpty) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (BuildContext context, int val) {
                return CovernorateItem(
                  imageURL: snapshot.data!.docs[val]['imageUrl'],
                  id: snapshot.data!.docs[val]['id'],
                  title: snapshot.data!.docs[val]['name'],
                  places: snapshot.data!.docs[val]['places'],
                );
              },
            );
          } else {
            return const Center(
              child: MyText(title: 'ليس هناك اي اماكن يمكنك زيرتها'),
            );
          }
        } else {
          return const Center(
            child: MyText(title: 'ليس هناك اي اماكن يمكنك زيرتها'),
          );
        }
      },
    ));
  }
}
