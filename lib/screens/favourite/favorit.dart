import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:egy_tour_guide/taps.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../widgets/my_text.dart';
import '../../widgets/places_item.dart';

class FavoritScreen extends StatefulWidget {
  const FavoritScreen({ Key? key }) : super(key: key);

  @override
  State<FavoritScreen> createState() => _FavoritScreenState();
}

class _FavoritScreenState extends State<FavoritScreen> {

  String uid = '';
  void gitUserId (){
  final _auth = FirebaseAuth.instance;
 User? user = _auth.currentUser;
      uid = user!.uid;
}
@override
  void initState() {
    
   gitUserId ();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: Builder(builder: (context) {
          return IconButton(
            onPressed: () {
                Navigator.of(context)
                    .pushReplacementNamed(TapsScreen.tapsRoute);
            },
            icon: const Icon(Icons.arrow_back_ios)
            ,
          );
        }),
        
        title:  const Text('خطه السياحة الخاصة بي'),
        centerTitle: true,
      ),
     body:StreamBuilder<QuerySnapshot>(
          stream:
              FirebaseFirestore.instance
      .collection('users').doc(uid).collection('likeUsers')
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
                      activitys:  snapshot.data!.docs[index]['placeActivitys'] ,
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
        ) ,
    );
  }
}