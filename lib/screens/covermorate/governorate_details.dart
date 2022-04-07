import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:egy_tour_guide/utils.dart';
import 'package:egy_tour_guide/widgets/form_widgets/my_button.dart';
import 'package:egy_tour_guide/widgets/my_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../../taps.dart';
import '../home/home_screen.dart';

class GovernorateDetails extends StatefulWidget {
  final String categoryId;
  final String categoryTitel;
  final String imageUrl;
  final String des;
  final String placeId;
  final String latLong;

  const GovernorateDetails({
    required this.categoryId,
    required this.categoryTitel,
    required this.imageUrl,
    required this.des,
    required this.placeId, required this.latLong,
  });

  @override
  State<GovernorateDetails> createState() => _GovernorateDetailsState();
}

class _GovernorateDetailsState extends State<GovernorateDetails> {
  
  // ignore: prefer_final_fields
  TextEditingController _commentControlar = TextEditingController();

  bool _isCommenting = false;
  String name = '';
  String imageUrl = '';
  String uid = '';

  @override
  void dispose() {
    _commentControlar.dispose();

    super.dispose();
  }

  @override
  void initState() {
    getUserData();
    // getData();
    super.initState();
  }

  var places = [];

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

  Widget buildSectionTitle(BuildContext context, String titleText) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      alignment: Alignment.topRight,
      child: Text(
        titleText,
        style: Theme.of(context).textTheme.headline5,
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
      height: 250,
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(horizontal: 15),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pushReplacementNamed(TapsScreen.tapsRoute);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: Text(widget.categoryTitel),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 300,
              width: double.infinity,
              child: Image.network(
                widget.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            _Bottons(),
            const SizedBox(height: 10),
            buildSectionTitle(context, 'معلومات عن المكان'),
            buildListViewContainer(MyText(
              title: widget.des,
              lines: 10,
            )),
            buildSectionTitle(context, 'الأنشطة'),
          
            buildListViewContainer(FutureBuilder<DocumentSnapshot>(
              future: FirebaseFirestore.instance
                  .collection('places')
                  .doc(widget.placeId)
                  .get(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  if (snapshot.data == null) {
                    return Container();
                  }
                }
                return ListView.builder(
                  itemCount: snapshot.data!['ad'].length,
                  itemBuilder: (ctx, index) => Card(
                    elevation: 0.3,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 10,
                      ),
                      child: Text(snapshot.data!['ad'][index]),
                    ),
                  ),
                );
              },
            )),
          
            const SizedBox(height: 10),
            buildSectionTitle(context, 'البرنامج اليومي'),
            buildListViewContainer(
              ListView.builder(
                itemCount: 3,
                itemBuilder: (ctx, index) => Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        child: Text('يوم ${index + 1}'),
                      ),
                      title: const Text("البرنااامج"),
                    ),
                    const Divider(),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 50),
            Padding(
                padding: const EdgeInsets.all(15.0),
                child: _isCommenting
                    ? AnimatedSwitcher(
                        duration: const Duration(milliseconds: 500),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Flexible(
                              flex: 5,
                              child: _textFormFilds(
                                controller: _commentControlar,
                                hint: 'اكتب تعليق',
                                enabled: true,
                                maxLines: 5,
                                maxLinght: 500,
                                valueKey: 'comment',
                                function: () {},
                              ),
                            ),
                            const SizedBox(width: 10),
                            Flexible(
                                flex: 2,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    MyButton(
                                        isVsabilIcon: true,
                                        icon: Icons.send,
                                        text: "ارسال",
                                        onPressed: () async {
                                          if (_commentControlar.text.length <
                                              7) {
                                            // ignore: avoid_single_cascade_in_expression_statements
                                            AwesomeDialog(
                                              context: context,
                                              dialogType: DialogType.WARNING,
                                              animType: AnimType.BOTTOMSLIDE,
                                              //  title: 'هل انت واثق من تسجيل الخروج ؟',
                                              desc: "يجب كتابه تعلق كافي",
                                              btnCancelOnPress: () {},
                                              btnOkOnPress: () async {},
                                            )..show();
                                          } else {
                                            final gnerateId = const Uuid().v4();
                                            await FirebaseFirestore.instance
                                                .collection('places')
                                                .doc(widget.placeId)
                                                .update({
                                              'placeComment':
                                                  FieldValue.arrayUnion([
                                                {
                                                  'commentID': gnerateId,
                                                  'name': name.toString(),
                                                  'commentBody':
                                                      _commentControlar.text,
                                                  'time': Timestamp.now(),
                                                  'userImage':
                                                      imageUrl.toString()
                                                }
                                              ]),
                                            });
                                            setState(() {});
                                            _commentControlar.text = '';
                                          }
                                        }),
                                    TextButton(
                                        onPressed: () {
                                          setState(() {
                                            _isCommenting = !_isCommenting;
                                          });
                                        },
                                        child: const MyText(
                                          title: 'الغاء التعليق',
                                        ))
                                  ],
                                ))
                          ],
                        ),
                      )
                    : MyButton(
                        text: ' تعليق',
                        icon: Icons.comment,
                        isVsabilIcon: true,
                        onPressed: () async {
                          setState(() {
                            _isCommenting = !_isCommenting;
                          });
                        },
                      )),
            const SizedBox(height: 40),
            Padding(
                padding: const EdgeInsets.all(20.0),
                child: FutureBuilder<DocumentSnapshot>(
                  future: FirebaseFirestore.instance
                      .collection('places')
                      .doc(widget.placeId)
                      .get(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      if (snapshot.data == null) {
                        return const Text('no comment');
                      }
                    }
                    return ListView.separated(
                      reverse: true,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data!['placeComment'].length,
                      itemBuilder: (context, index) {
                        return _commentWidget(
                          comanterImageUrl: snapshot.data!['placeComment']
                              [index]['userImage'],
                          comanterName: snapshot.data!['placeComment'][index]
                              ['name'],
                          commentBody: snapshot.data!['placeComment'][index]
                              ['commentBody'],
                          commentId: snapshot.data!['placeComment'][index]
                              ['commentID'],
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const Divider();
                      },
                    );
                  },
                )),
          ],
        ),
      ),
    );
  }

  void addLike(bool like) {
    like = !like;
    if (like) {
      DocumentReference docRef = FirebaseFirestore.instance
          .collection('places')
          .doc(widget.placeId)
          .collection('likeUsers')
          .doc(uid);
      docRef.set({'imageUrl': imageUrl, 'name': name, 'time': DateTime.now()});
      DocumentReference docRefUser =FirebaseFirestore.instance
      .collection('users').doc(uid).collection('likeUsers').doc(widget.placeId);
       docRefUser.set({
         'gid': widget.categoryId,
         'imageUrl' :widget.imageUrl ,
         'name' : widget.categoryTitel ,
         'des' : widget.des,
         'placeID' :widget.placeId,
         'latLong' : widget.latLong,
       });
    } else {
      DocumentReference docRef = FirebaseFirestore.instance
          .collection('places')
          .doc(widget.placeId)
          .collection('likeUsers')
          .doc(uid);
      docRef.delete();
       DocumentReference docRefUser =FirebaseFirestore.instance
      .collection('users').doc(uid).collection('likeUsers').doc(widget.placeId);
       docRefUser.delete();
    }
  }

  Widget _commentWidget({
    required String commentId,
    required String commentBody,
    required String comanterImageUrl,
    required String comanterName,
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
              image: NetworkImage(comanterImageUrl),
            ),
          ),
        ),
        const SizedBox(
          width: 15,
        ),
        Flexible(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyText(
                title: comanterName.toUpperCase(),
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
              MyText(
                title: commentBody.toString(),
              ),
            ],
          ),
        )
      ],
    );
  }


  _textFormFilds({
    required String valueKey,
    required String hint,
    //required TextEditingController controller,
    required bool enabled,
    required VoidCallback function,
    required int maxLinght,
    required int maxLines,
    required TextEditingController controller,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: function,
        child: TextFormField(
          controller: controller,
          validator: (value) {
            if (value!.isEmpty) {
              return 'is empty';
            } else {
              return null;
            }
          },
          key: ValueKey(valueKey),
          enabled: enabled,
          // controller: controller,
          maxLines: maxLines,
          maxLength: maxLinght,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: Theme.of(context).scaffoldBackgroundColor,
          ),
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget _Bottons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(child: Container()),
        StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection('places')
              .doc(widget.placeId)
              .collection('likeUsers')
              .doc(uid)
              .snapshots(),
          builder: (context, snapshot) {
            if(snapshot.hasError){
              return const Text('لقد حدث خطأ');
            }
            if (!snapshot.hasData) {
              return const Center(
                  child: Icon(
                Icons.favorite_border,
                color: Colors.red,
              ));
            }
            if (snapshot.data!.exists) {
              return IconButton(
                icon: const Icon(Icons.favorite, color: Colors.red),
                onPressed: () {
                  addLike(true);
                },
              );
            } else {
              return IconButton(
                icon: const Icon(Icons.favorite_border, color: Colors.red),
                onPressed: () {
                  addLike(false);
                },
              );
            }
          },
        ),
        StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('places')
              .doc(widget.placeId)
              .collection('likeUsers').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text(snapshot.data!.docs.length.toString());
            }
           
              return const Text("0");
            
          },
        ),
        Expanded(child: Container()),
        IconButton(
          icon: const Icon(
            Icons.add_comment,
            color: Colors.teal,
          ),
          onPressed: () {},
        ),
        const Text('التعليقات'),
        Expanded(child: Container()),
        IconButton(
          icon: const Icon(
            Icons.map,
            color: Colors.red,
          ),
          onPressed: ()=>Utils.openGoogleMap(latLong: widget.latLong),
          
        ),
       const Text('الخريطة'),
        Expanded(child: Container()),
      ],
    );
  }
   
}
