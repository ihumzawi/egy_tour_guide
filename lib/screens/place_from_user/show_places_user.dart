import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../constant/constant.dart';
import '../../taps.dart';
import '../../widgets/my_text.dart';
import '../../widgets/user_plece_item.dart';

class ShowPlacesUser extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("المزارات المتوفرة داخل"),
          actions: [
            IconButton(
                onPressed:()=> chooseFilterDialog(context,size),
                icon: const Icon(Icons.filter_list_rounded))
          ],
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.of(context).pushReplacementNamed(TapsScreen.tapsRoute);
            },
          ),
        ),
        body: ListView.builder(
            itemCount: 20,
            itemBuilder: (context, index) {
              return UserPlaceItem();
            }));
  }
   AwesomeDialog chooseFilterDialog(BuildContext context, Size size) {
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
                      title: 'اختار التصنيف المناسب',
                      fontWeight: FontWeight.bold,
                    ),
                    SizedBox(
                      width: size.width * 0.9,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: Constant.placeCatigoryList.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
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
                                      title:
                                          Constant.placeCatigoryList[index],
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




   
      // body: StreamBuilder<QuerySnapshot>(
      //   stream: FirebaseFirestore.instance
      //       .collection('places')
      //       .where('gid', isEqualTo: widget.categoryId)
      //       .snapshots(),
      //   builder: (context, snapshot) {
      //     if (snapshot.connectionState == ConnectionState.waiting) {
      //       return const Center(
      //         child: CircularProgressIndicator(),
      //       );
      //     } else if (snapshot.connectionState == ConnectionState.active) {
      //       if (snapshot.data!.docs.isNotEmpty) {
      //         return ListView.builder(
      //           itemCount: snapshot.data!.docs.length,
      //           itemBuilder: ((context, index) {
      //             return PlacesItem(
      //               id: snapshot.data!.docs[index]['gid'],
      //               imageUrl: snapshot.data!.docs[index]['imageUrl'],
      //               title: snapshot.data!.docs[index]['name'],
      //               des:snapshot.data!.docs[index]['des'] ,
      //               placeId:snapshot.data!.docs[index]['placeID'],
      //               latLong: snapshot.data!.docs[index]['latLong'] ,
      //             );
      //           }),
      //         );
      //       } else {
      //         return const Center(
      //           child: MyText(title: 'لا يوجد اماكن متوفرة'),
      //         );
      //       }
      //     } else {
      //       return const Center(
      //         child: MyText(title: 'لقد حدث خطأ'),
      //       );
      //     }
      //   },
      // )
    // );
