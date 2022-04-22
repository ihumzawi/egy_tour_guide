import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:egy_tour_guide/constant/constant.dart';
import 'package:egy_tour_guide/utils.dart';
import 'package:egy_tour_guide/widgets/form_widgets/my_button.dart';
import 'package:egy_tour_guide/widgets/my_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../../taps.dart';
import '../../widgets/form_widgets/my_text_field.dart';

class GovernorateDetails extends StatefulWidget {
  final String categoryId;
  final String categoryTitel;
  final String imageUrl;
  final String des;
  final String placeId;
  final String latLong;
  final String activitys;

  // ignore: use_key_in_widget_constructors
  const GovernorateDetails({
    required this.categoryId,
    required this.categoryTitel,
    required this.imageUrl,
    required this.des,
    required this.placeId,
    required this.latLong,
    required this.activitys,
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
      child: MyText(
      title:  "$titleText :",
       fontSize: 20,
       color: Colors.blue,
       fontWeight: FontWeight.bold,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constant.bgColor,
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

           
 bottons(),
            
          
            Card(child: Column(
              children: [
                buildSectionTitle(context, 'معلومات عن المكان'),
                 buildListViewContainer(MyText(
              title: widget.des,
              lines: 250,
            )),
             const SizedBox(height: 16),
              ],
            )),
           
           
            Card(child: Column(
              children: [
                buildSectionTitle(context, 'البرنامج اليومي'),
               
                buildListViewContainer(
              MyText(
                title: widget.activitys,
                lines: 100,
              ),
            ),
             const SizedBox(height: 16),
              ],
            )),
           
            Card(

              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                     buildSectionTitle(context, 'الموقع علي الخريطة '),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Image.asset('assets/images/map.png'),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: MaterialButton(
                            onPressed: () =>
                                Utils.openGoogleMap(latLong: widget.latLong),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                MyText(
                                  title: 'اضغط للمشاهده ',
                                  fontSize: 16,
                                ),
                                Icon(
                                  Icons.location_on_outlined,
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
            
              Card(
              child: Column(
                children: [
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
                                    child: textFormField(
                                      onTapInk: () {},
                                      enabled: true,
                                      valueKey: 'comment',
                                      hint: 'قم بكتابة تعليق',
                                      controller: _commentControlar,
                                      maxLines: 4,
                                      maxLength: 250,
                                      enabledBorderRadius: false,
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
                             commentsListVeiw(),
                ],
              ),
            ),
            const SizedBox(height: 40),
           
          ],
        ),
      ),
    );
  }

  Padding commentsListVeiw() {
    return Padding(
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
                      comanterImageUrl: snapshot.data!['placeComment'][index]
                          ['userImage'],
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
      DocumentReference docRefUser = FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('likeUsers')
          .doc(widget.placeId);
      docRefUser.set({
        'gid': widget.categoryId,
        'imageUrl': widget.imageUrl,
        'name': widget.categoryTitel,
        'des': widget.des,
        'placeID': widget.placeId,
        'latLong': widget.latLong,
        'placeActivitys': widget.activitys,
      });
    } else {
      DocumentReference docRef = FirebaseFirestore.instance
          .collection('places')
          .doc(widget.placeId)
          .collection('likeUsers')
          .doc(uid);
      docRef.delete();
      DocumentReference docRefUser = FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('likeUsers')
          .doc(widget.placeId);
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

  // ignore: non_constant_identifier_names
  Widget bottons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection('places')
              .doc(widget.placeId)
              .collection('likeUsers')
              .doc(uid)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Text('لقد حدث خطأ');
            }
            if (!snapshot.hasData) {
              return const Center(
                  child: Icon(
                Icons.bookmark_outline,
                color: Colors.red,
              ));
            }
            if (snapshot.data!.exists) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: MaterialButton(
                    onPressed: () {
                      addLike(true);
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(
                          Icons.bookmark,
                          color: Colors.amber,
                        ),
                        MyText(
                          title: 'اضغط للحفظ ',
                          fontSize: 16,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: MaterialButton(
                    onPressed: () {
                      addLike(false);
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(
                          Icons.bookmark_outline,
                          color: Colors.amber,
                        ),
                        MyText(
                          title: 'اضغط للحفظ ',
                          fontSize: 16,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
          },
        ),
        
        StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('places')
              .doc(widget.placeId)
              .collection('likeUsers')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if(snapshot.data!.docs.length >= 2){
                return MyText(title: 'انت تخطط للزيارة و ${snapshot.data!.docs.length.toString()} اخرون',fontSize: 15,);
              }
              if(snapshot.data!.docs.length == 1){
                return const MyText(title: 'محفوظ في قائمة المخطط له',fontSize: 15,);
              }
              if(snapshot.data!.docs.isEmpty){
                return const MyText(title: 'احفظ في قائمة المخطط له',);
              }
              return MyText(title: 'انت تخطط للزيارة و ${snapshot.data!.docs.length.toString()} اخرون',fontSize: 15,);
            }

            return const Text("");
          },
        ),
        Expanded(child: Container()),
       
      ],
    );
  }
}
