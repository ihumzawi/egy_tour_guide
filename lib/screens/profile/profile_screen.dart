import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:egy_tour_guide/palette.dart';
import 'package:egy_tour_guide/widgets/form_widgets/my_button.dart';
import 'package:egy_tour_guide/widgets/my_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../auth/welcome_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _auth = FirebaseAuth.instance;

  bool _isLoding = false;
  String email = '';
  String name = '';
  String imageUrl = '';
  String joinedAt = '';
  bool _isSameUser = false;
  @override
  void initState() {
    super.initState();
    getUserData();
  }

  void getUserData() async {
    _isLoding = true;
    try {
      final DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .get();
      // ignore: unnecessary_null_comparison
      if (userDoc == null) {
        return;
      } else {
        setState(() {
          email = userDoc.get('email');
          name = userDoc.get('name');
          imageUrl = userDoc.get('userImageURL');
          Timestamp joinedAtTimeStamp = userDoc.get('createdAd');
          var joindDate = joinedAtTimeStamp.toDate();
          joinedAt =
              '${joindDate.year} - ${joindDate.month} - ${joindDate.day}';
        });
        User? user = _auth.currentUser;
        String _uid = user!.uid;
      }
    } catch (err) {
      print('------------------errer ------------');
    } finally {
      setState(() {
        _isLoding = false ;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                )),
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        image: DecorationImage(image: _isLoding ? const NetworkImage('https://cdn-icons-png.flaticon.com/512/149/149071.png') : NetworkImage(imageUrl) ,),),
                  ),
                  MyText(
                    title: name.toUpperCase(),
                    color: kWhite,
                    fontSize: 20,
                  ),
                  MyText(
                    // ignore: unnecessary_brace_in_string_interps
                    title: 'تاريخ التسجيل (${joinedAt})  ',
                    color: kWhite,
                    fontSize: 10,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 20, right: 20, left: 20),
            child: MyText(
              title: 'البريد الالكتروني :',
              fontSize: 20,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 40, left: 40),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  MyButton(
                    width: double.infinity,
                    textColor: kWhite,
                    color: Colors.grey,
                    text: email.toUpperCase(),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  MyButton(
                    width: double.infinity,
                    text: 'تسجيل الخروج ',
                    color: kRed,
                    icon: Icons.logout_outlined,
                    isVsabilIcon: true,
                    onPressed: (){
                       // ignore: avoid_single_cascade_in_expression_statements
                      AwesomeDialog(
            context: context,
            dialogType: DialogType.WARNING,
            animType: AnimType.BOTTOMSLIDE,
          //  title: 'هل انت واثق من تسجيل الخروج ؟',
           desc: 'هل انت واثق من تسجيل الخروج ؟',
            btnCancelOnPress: () {
            },
            btnOkOnPress: () async{
              await FirebaseAuth.instance.signOut();
                Navigator.of(context)
                    .pushReplacementNamed(WelcomeScreen.welcomeRoute);
            },
            )..show();
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  MyButton(
                    width: double.infinity,
                    text: 'تعديل المعلومات ',
                    color: kBlue,
                    icon: Icons.edit,
                    isVsabilIcon: true,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
