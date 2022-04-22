// ignore_for_file: use_key_in_widget_constructors

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:egy_tour_guide/widgets/my_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:uuid/uuid.dart';

import '../../../../widgets/form_widgets/my_button.dart';
import '../../../../widgets/form_widgets/my_text_field.dart';

class ReviewPlacesDetalis extends StatefulWidget {
  final String titel;
  final String userName;
  final String userImageUrl;
  final String description;
  final String location;
  final String catigory;
  final String placeId;
  final String placeImageUrl;
  // ignore: prefer_const_constructors_in_immutables
  ReviewPlacesDetalis({
    Key? key,
    required this.titel,
    required this.userName,
    required this.userImageUrl,
    required this.description,
    required this.location,
    required this.catigory,
    required this.placeId,
    required this.placeImageUrl,
  }) : super(key: key);

  @override
  State<ReviewPlacesDetalis> createState() => _ReviewPlacesDetalisState();
}

class _ReviewPlacesDetalisState extends State<ReviewPlacesDetalis> {
  double rating = 0;
  TextEditingController ratingControlar = TextEditingController();
  String name = '';
  String imageUrl = '';
  String uid = '';
  final imagesUrl = [];
  final List<double> ratingList = [];
  double ratRisto = 0;
  bool imageVew = false;
  void getUserData() async {
    try {
      final _auth = FirebaseAuth.instance;
      User? user = _auth.currentUser;
      String _uid = user!.uid;
      final DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .get();
      // ignore: unnecessary_null_comparison
      if (userDoc == null) {
        return;
      } else {
        setState(() {
          name = userDoc.get('name');
          imageUrl = userDoc.get('userImageURL');
          uid = _uid;
        });
      }
    } catch (err) {
      print('------------------errer ------------');
    } finally {}
  }

  void getImageData() async {
    await FirebaseFirestore.instance
        .collection('userPlaces')
        .doc(widget.placeId)
        .collection('imageUrl')
        .get()
        .then((value) {
      for (var element in value.docs) {
        setState(() {
          imagesUrl.add(element.get('url'));
        });
      }
    });
  }

  void getUserRat() async {
    await FirebaseFirestore.instance
        .collection('userPlaces')
        .doc(widget.placeId)
        .collection('ratingUsers')
        .get()
        .then((value) {
      for (var element in value.docs) {
        setState(() {
          rating = element.get('ratValue');
          ratingList.add(element.get('ratValue'));
          ratRisto = (ratingList.reduce((a, b) => a + b)) / ratingList.length;
        });
      }
    });
  }

  @override
  void initState() {
    getImageData();
    getUserData();
    getUserRat();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    final List<Widget> imageSliders = imagesUrl
        .map((item) => InkWell(
            onTap: openGallery,
            child: Container(
              margin: const EdgeInsets.all(0.0),
              child: Image.network(item, fit: BoxFit.cover, width: 1000.0),
            )))
        .toList();
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => floatingActionButtonPress(size),
        icon: const Icon(
          Icons.star,
          color: Colors.amber,
        ),
        label: const MyText(
          title: 'تقيم',
          color: Colors.white,
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: MyText(
          color: Colors.white,
          title: widget.titel,
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back_ios,
            )),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CarouselSlider(
              options: CarouselOptions(
                  autoPlay: false,
                  aspectRatio: 2.0,
                  enlargeCenterPage: false,
                  viewportFraction: 1),
              items: imageSliders,
            ),
            ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: NetworkImage(widget.userImageUrl),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      MyText(
                        title: widget.userName,
                        fontSize: 13,
                      )
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_pin,
                        size: 30,
                        color: Colors.blue,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      MyText(
                        title: widget.location,
                        fontSize: 13,
                      )
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.category_rounded,
                        size: 30,
                        color: Colors.blue,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      MyText(
                        title: widget.catigory,
                        fontSize: 13,
                      )
                    ],
                  ),
                ],
              ),
            ),
            ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      RatingBarIndicator(
                        rating: ratRisto,
                        itemBuilder: (context, index) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        itemCount: 5,
                        itemSize: 20.0,
                        direction: Axis.horizontal,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      MyText(
                        title: ratRisto.toString(),
                      )
                    ],
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  const MyText(
                    title: ' معدل تقيم المستخدمين',
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  buildSectionTitle(widget.titel),
                  buildListViewContainer(MyText(
                    title: widget.description,
                    lines: 200,
                  )),
                  // comments and rateing
                  const Divider(
                    thickness: 2,
                  ),
                  StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('userPlaces')
                        .doc(widget.placeId)
                        .collection('ratingUsers')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else {
                        if (snapshot.data == null) {
                          return const Text('no rating');
                        }
                      }
                      return ListView.separated(
                        reverse: true,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          return _ratCommentWidget(
                            ratImageUrl: snapshot.data!.docs[index]
                                ['userImage'],
                            ratName: snapshot.data!.docs[index]['name'],
                            ratBody: snapshot.data!.docs[index]['textRating'],
                            ratId: snapshot.data!.docs[index]['ratId'],
                            ratingValue: snapshot.data!.docs[index]['ratValue'],
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const Divider(
                            thickness: 2,
                          );
                        },
                      );
                    },
                  ),
                  buildSectionTitle('الموافقع علي المنشور او الحذف'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      MyButton(
                        text: 'موافقة',
                        icon: Icons.done,
                        color: Colors.green,
                        isVsabilIcon: true,
                        onPressed: () {
                          try {
                            FirebaseFirestore.instance
                                .collection('userPlaces')
                                .doc(widget.placeId)
                                .update({
                              'isDone': true,
                            });
                             Navigator.of(context).pop();
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.SUCCES,
                              animType: AnimType.BOTTOMSLIDE,
                              body: Column(
                                children: const [
                                  MyText(title: 'تم النشر'),
                                  SizedBox(
                                    height: 10,
                                  )
                                ],
                              ),
                            ).show();
                          } catch (e) {
                            print('$e ________________________');
                          }
                        },
                      ),
                      MyButton(
                        onPressed: () async {
                          try {
                            var collection = FirebaseFirestore.instance
                                .collection('userPlaces');
                            collection.doc(widget.placeId).delete();

                            var snapshots = await collection
                                .doc(widget.placeId)
                                .collection('imageUrl')
                                .get();
                            for (var doc in snapshots.docs) {
                              await doc.reference.delete();
                            }
                             Navigator.of(context).pop();
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.SUCCES,
                              animType: AnimType.BOTTOMSLIDE,
                              body: Column(
                                children: const [
                                  MyText(title: 'تم حذف الاعلان'),
                                  SizedBox(
                                    height: 10,
                                  )
                                ],
                              ),
                            ).show();
                          } catch (e) {
                            print('$e ________________________');
                          }
                        },
                        text: 'حذف ',
                        isVsabilIcon: true,
                        icon: Icons.delete,
                        color: Colors.red,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _ratCommentWidget({
    required String ratId,
    required String ratBody,
    required String ratImageUrl,
    required String ratName,
    required double ratingValue,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            image: DecorationImage(
              image: NetworkImage(ratImageUrl),
            ),
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        Flexible(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyText(
                title: ratName.toUpperCase(),
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
              RatingBarIndicator(
                rating: ratingValue,
                itemBuilder: (context, index) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                itemCount: 5,
                itemSize: 20.0,
                direction: Axis.horizontal,
              ),
              const SizedBox(
                height: 10,
              ),
              MyText(
                title: ratBody.toString(),
                lines: 4,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildListViewContainer(Widget child) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(horizontal: 15),
      child: child,
    );
  }

  Widget buildSectionTitle(String titleText) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      alignment: Alignment.topRight,
      child: Text(
        titleText,
        style: Theme.of(context).textTheme.headline5,
      ),
    );
  }

  Column textFormField({
    required String valueKey,
    required String hint,
    required TextEditingController controller,
    required VoidCallback onTapInk,
    bool enabled = true,
    bool enabledBorderRadius = true,
    bool isIconVisiblePrefix = false,
    int maxLines = 1,
    int maxLength = 25,
  }) =>
      Column(
        children: [
          InkWell(
            onTap: onTapInk,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: MyTextField(
                controller: controller,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'الحقل مطلوب';
                  }
                  return null;
                },
                enabledBorderRadius: enabledBorderRadius,
                isIconVisiblePrefix: isIconVisiblePrefix,
                hint: hint,
                textInputAction: TextInputAction.next,
                textInputType: TextInputType.name,
                enabled: enabled,
                isKey: ValueKey(valueKey),
                maxLines: maxLines,
                maxLength: maxLength,
              ),
            ),
          ),
        ],
      );

  Padding kTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(right: 20, left: 20, bottom: 0, top: 20),
      child: Row(
        children: [
          MyText(
            title: title,
            color: const Color.fromARGB(255, 101, 101, 101),
          ),
          const Text(
            ' *',
            style: TextStyle(color: Colors.red, fontSize: 20),
          )
        ],
      ),
    );
  }

  void openGallery() => Navigator.of(context).push(
        MaterialPageRoute(
            builder: (_) => GalleryWidget(
                  urlImageList: imagesUrl,
                )),
      );

  void floatingActionButtonPress(size) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.NO_HEADER,
      animType: AnimType.BOTTOMSLIDE,
      btnCancelOnPress: () {},
      btnOkOnPress: () async {
        final gnerateId = const Uuid().v4();

        DocumentReference docRef = FirebaseFirestore.instance
            .collection('userPlaces')
            .doc(widget.placeId)
            .collection('ratingUsers')
            .doc(uid);
        docRef.set({
          'ratId': gnerateId,
          'name': name,
          'time': DateTime.now(),
          'textRating': ratingControlar.text,
          'ratValue': rating,
          'userImage': imageUrl.toString()
        });
        setState(() {
          ratingControlar.clear();
        });
      },
      btnCancelText: 'اغلاق',
      body: Column(
        children: [
          const MyText(
            title: 'قيم المكان',
            fontWeight: FontWeight.bold,
          ),
          RatingBar.builder(
              updateOnDrag: true,
              minRating: 1,
              initialRating: rating,
              itemBuilder: (_, i) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
              onRatingUpdate: (rating) {
                this.rating = rating;
              }),
          SizedBox(
            width: size.width * 0.9,
            child: textFormField(
              onTapInk: () {},
              enabled: true,
              valueKey: 'comment',
              hint: 'قم بكتابة تعليق',
              controller: ratingControlar,
              maxLines: 4,
              maxLength: 150,
              enabledBorderRadius: false,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    ).show();
  }
}

class GalleryWidget extends StatefulWidget {
  final List urlImageList;
  const GalleryWidget({
    required this.urlImageList,
  });

  @override
  State<GalleryWidget> createState() => _GalleryWidgetState();
}

class _GalleryWidgetState extends State<GalleryWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PhotoViewGallery.builder(
          itemCount: widget.urlImageList.length,
          builder: (context, i) {
            final urlList = widget.urlImageList[i];
            return PhotoViewGalleryPageOptions(
              imageProvider: NetworkImage(urlList),
            );
          }),
    );
  }
}
