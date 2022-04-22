import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:egy_tour_guide/screens/ads/ads_details.dart';
import 'package:flutter/material.dart';
import '../../taps.dart';
import '../../widgets/my_text.dart';
import '../../widgets/user_plece_item.dart';

class AllAdsScreen extends StatefulWidget {
  const AllAdsScreen({Key? key}) : super(key: key);

  @override
  State<AllAdsScreen> createState() => _AllAdsScreenState();
}

class _AllAdsScreenState extends State<AllAdsScreen> {
  @override
  void initState() {
    // getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("استمتع فأفضل العروض المختارة"),
        
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pushReplacementNamed(TapsScreen.tapsRoute);
          },
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('ads')
              .where('isDone', isEqualTo: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Text('Something went wrong');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.data!.docs.isEmpty) {
              return const Center(
                  child: MyText(
                title: 'لا توجد عروض متوفرة للاسف',
              ));
            }
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  return UserPlaceItem(
                    titel: snapshot.data!.docs[index]['placeTitle'],
                    userImage: snapshot.data!.docs[index]['userImage'],
                    userPlaceUrl: snapshot.data!.docs[index]['placeImage'],
                    name: snapshot.data!.docs[index]['userName'],
                    location: snapshot.data!.docs[index]['location'],
                    selectItem: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return AdsDetalisScreen(
                          titel: snapshot.data!.docs[index]['placeTitle'],
                          description: snapshot.data!.docs[index]
                              ['placeDescripton'],
                          location: snapshot.data!.docs[index]['location'],
                          userImageUrl: snapshot.data!.docs[index]['userImage'],
                          userName: snapshot.data!.docs[index]['userName'],
                          placeId: snapshot.data!.docs[index]['placeId'],
                          placeImageUrl: snapshot.data!.docs[index]
                              ['placeImage'],
                          phone: snapshot.data!.docs[index]['phone'],
                        );
                      }));
                    },
                  );
                });
          }),
    );
  }


}
