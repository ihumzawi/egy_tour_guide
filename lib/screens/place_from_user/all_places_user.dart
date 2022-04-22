import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:egy_tour_guide/screens/place_from_user/user_plece_details.dart';
import 'package:flutter/material.dart';
import '../../constant/constant.dart';
import '../../taps.dart';
import '../../widgets/my_text.dart';
import '../../widgets/user_plece_item.dart';

class AllPlacesUser extends StatefulWidget {
  const AllPlacesUser({Key? key}) : super(key: key);

  @override
  State<AllPlacesUser> createState() => _AllPlacesUserState();
}

class _AllPlacesUserState extends State<AllPlacesUser> {
  String? locationFilter;
  @override
  void initState() {
    // getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("ترشيحات المستخدمين"),
        actions: [
          IconButton(
              onPressed: () => chooseFilterDialog(size),
              icon: const Icon(Icons.filter_list_rounded))
        ],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pushReplacementNamed(TapsScreen.tapsRoute);
          },
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: locationFilter == null
              ? FirebaseFirestore.instance
                  .collection('userPlaces')
                  .where('isDone', isEqualTo: true)
                  .snapshots()
              : FirebaseFirestore.instance
                  .collection('userPlaces')
                  .where('isDone', isEqualTo: true)
                  .where('location', isEqualTo: locationFilter)
                  .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Text('Something went wrong');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.data!.docs.isEmpty) {
              return const Center(child: MyText(title: 'لا توجد اي منشورات',));
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
                      return UserPlaceDetails(
                        titel: snapshot.data!.docs[index]['placeTitle'],
                        description: snapshot.data!.docs[index]
                            ['placeDescripton'],
                        location: snapshot.data!.docs[index]['location'],
                        catigory: snapshot.data!.docs[index]
                            ['userPlaceCategory'],
                        userImageUrl: snapshot.data!.docs[index]['userImage'],
                        userName: snapshot.data!.docs[index]['userName'],
                        placeId: snapshot.data!.docs[index]['placeId'],
                        placeImageUrl: snapshot.data!.docs[index]['placeImage'],
                      );
                    }));
                  },
                );
              },
            );
          }),
    );
  }

  AwesomeDialog chooseFilterDialog(Size size) {
    return AwesomeDialog(
      context: context,
      dialogType: DialogType.NO_HEADER,
      animType: AnimType.BOTTOMSLIDE,

      //  title: 'هل انت واثق من تسجيل الخروج ؟',
      btnCancelOnPress: () {},
      btnCancelText: 'اغلاق',
      body: Column(
        children: [
          const MyText(
            title: 'اختر مكان المزار',
            fontWeight: FontWeight.bold,
          ),
          SizedBox(
            width: size.width * 0.9,
            height: size.width * .9,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: Constant.goverNoRate.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          locationFilter = Constant.goverNoRate[index];
                        });
                        if (Navigator.of(context).canPop()) {
                          Navigator.of(context).pop();
                        }
                      },
                      child: Row(
                        children: [
                          const Icon(Icons.check_circle),
                          const SizedBox(
                            width: 10,
                          ),
                          MyText(
                            title: Constant.goverNoRate[index],
                          ),
                        ],
                      ),
                    );
                  }),
            ),
          ),
        ],
      ),
    )..show();
  }
}
