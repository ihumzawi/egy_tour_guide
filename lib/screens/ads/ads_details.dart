// ignore_for_file: use_key_in_widget_constructors

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:egy_tour_guide/utils.dart';
import 'package:egy_tour_guide/widgets/my_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view_gallery.dart';

class AdsDetalisScreen extends StatefulWidget {
  final String titel;
  final String userName;
  final String userImageUrl;
  final String description;
  final String location;
  final String phone;

  final String placeId;
  final String placeImageUrl;
  // ignore: prefer_const_constructors_in_immutables
  AdsDetalisScreen({
    Key? key,
    required this.titel,
    required this.userName,
    required this.userImageUrl,
    required this.description,
    required this.location,
    required this.placeId,
    required this.placeImageUrl,
    required this.phone,
  }) : super(key: key);

  @override
  State<AdsDetalisScreen> createState() => _AdsDetalisScreenState();
}

class _AdsDetalisScreenState extends State<AdsDetalisScreen> {
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
        .collection('ads')
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

  @override
  void initState() {
    getImageData();
    getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
        onPressed: () => floatingActionButtonPress(),
        icon: SizedBox(
            height: 30,
            width: 30,
            child: Image.network(
              'https://upload.wikimedia.org/wikipedia/commons/5/5e/WhatsApp_icon.png',
              scale: 1,
            )),
        label: const MyText(
          title: 'التواصل بالوتساب',
          color: Colors.white,
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: MyText(
          color: Colors.white,
          title: widget.titel,
          lines: 1,
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
                ],
              ),
            ),
          ],
        ),
      ),
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

  void floatingActionButtonPress() {
    Utils.openWhatsApp(
        numper: widget.phone,
        text: 'مرحبا اريد الاستفسار عن عرض ${widget.titel}');
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
