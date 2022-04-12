import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../taps.dart';
import '../../widgets/my_text.dart';

class OffersList extends StatelessWidget {
//  final String id;
//   final String title;
//   final String imageURL;
  static const String screenroute = 'offerslist';

  // ignore: use_key_in_widget_constructors
  const OffersList() ;
 

 

  @override
  Widget build(BuildContext context) {
    final cat = ModalRoute.of(context)!.settings.arguments as Map<String ,String> ;
    // ignore: unused_local_variable
    final title = cat['titel'] ;
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
        
        title:  Text(title.toString()),
        centerTitle: true,
      ),
      body:StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('offers').snapshots(),
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
                    return CardOffer(
                      context,title: snapshot.data!.docs[index]['title'],imageURL: snapshot.data!.docs[index]['imageUrl']
                      
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
        )
    );
  }

  // ignore: non_constant_identifier_names
  Widget CardOffer (
    BuildContext context,
    {
      required String imageURL,
      required String title,
    }
  ){
  return   InkWell(
      onTap: () {},
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
                  child: Image.network(imageURL, height: 250,width: double.infinity,
                  fit: BoxFit.cover,
                  ),

                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: MyText(title: title , color: Colors.red, fontSize: 25,),
            )
          ],
        ),
      ),
    );
  }

}