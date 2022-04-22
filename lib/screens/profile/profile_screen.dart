import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:egy_tour_guide/admin/review/review_ads/review_ads.dart';
import 'package:egy_tour_guide/admin/review/review_ads/review_user_places/review_places.dart';
import 'package:egy_tour_guide/palette.dart';
import 'package:egy_tour_guide/screens/profile/edit_profile.dart';
import 'package:egy_tour_guide/widgets/form_widgets/my_button.dart';
import 'package:egy_tour_guide/widgets/my_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../taps.dart';
import '../auth/welcome_screen.dart';

class ProfileScreen extends StatefulWidget {
  static const String route = 'profile';
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _uid = '';
  void gitUserId() {
    final _auth = FirebaseAuth.instance;
    User? user = _auth.currentUser;
    _uid = user!.uid;
  }

  @override
  void initState() {
    gitUserId();
    getUserData();
    super.initState();
  }

  final _auth = FirebaseAuth.instance;
  bool _isLoding = false;
  String email = '';
  String name = '';
  String imageUrl = '';
  String joinedAt = '';
  // ignore: prefer_final_fields, unused_field
  bool _isSameUser = false;
  bool isAdmin = false;

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
          isAdmin = userDoc.get('isAdmin');
          imageUrl = userDoc.get('userImageURL');
          Timestamp joinedAtTimeStamp = userDoc.get('createdAd');
          var joindDate = joinedAtTimeStamp.toDate();
          joinedAt =
              '${joindDate.year} - ${joindDate.month} - ${joindDate.day}';
        });
      }
    } catch (err) {
      print('------------------errer ------------');
    } finally {
      setState(() {
        _isLoding = false;
      });
    }
  }

  // test

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: Builder(builder: (context) {
          return IconButton(
            onPressed: () {
              Navigator.of(context).pushReplacementNamed(TapsScreen.tapsRoute);
            },
            icon: const Icon(Icons.arrow_back_ios),
          );
        }),
        title: const Text('الملف الشخصي'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
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
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: _isLoding
                                ? const NetworkImage(
                                    'https://cdn-icons-png.flaticon.com/512/149/149071.png')
                                : NetworkImage(imageUrl),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MyText(
                            title: name.toUpperCase(),
                            color: kWhite,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          isAdmin
                              ? const Icon(
                                  Icons.verified_rounded,
                                  color: Colors.amber,
                                )
                              : Container(),
                        ],
                      ),
                      MyText(
                        // ignore: unnecessary_brace_in_string_interps
                        title: 'تاريخ التسجيل (${joinedAt})  ',
                        color: kWhite,
                        fontSize: 15,
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
                        icon: Icons.mail_outline,
                        isVsabilIcon: true,
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
                        onPressed: () {
                          // ignore: avoid_single_cascade_in_expression_statements
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.WARNING,
                            animType: AnimType.BOTTOMSLIDE,
                            //  title: 'هل انت واثق من تسجيل الخروج ؟',
                            desc: 'هل انت واثق من تسجيل الخروج ؟',
                            btnCancelOnPress: () {},
                            btnOkOnPress: () async {
                              await FirebaseAuth.instance.signOut();
                              Navigator.of(context).pushReplacementNamed(
                                  WelcomeScreen.welcomeRoute);
                            },
                          )..show();
                        },
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      MyButton(
                        onPressed: () => Navigator.of(context)
                            .pushReplacementNamed(EditProfile.route),
                        width: double.infinity,
                        text: 'تعديل المعلومات ',
                        color: kBlue,
                        icon: Icons.edit,
                        isVsabilIcon: true,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      MyButton(
                        onPressed: () {
                          // ignore: avoid_single_cascade_in_expression_statements
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.WARNING,
                            animType: AnimType.BOTTOMSLIDE,
                            //  title: 'هل انت واثق من تسجيل الخروج ؟',
                            desc:
                                'هل انت واثق من حذف الحساب؟ سوف تخسر جميع بياناتك علي التطبيق',
                            btnCancelOnPress: () {},
                            btnOkOnPress: () async {
                              await _auth.currentUser?.delete();
                              DocumentReference docRefUser = FirebaseFirestore
                                  .instance
                                  .collection('users')
                                  .doc(_uid);
                              docRefUser.delete();
                              Navigator.of(context).pushReplacementNamed(
                                  WelcomeScreen.welcomeRoute);
                            },
                          )..show();
                        },
                        width: double.infinity,
                        text: 'حذف الحساب ',
                        color: Colors.red,
                        icon: Icons.delete,
                        isVsabilIcon: true,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      isAdmin
                          ? MyButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const ReviewAdsScreen(),
                                  ),
                                );
                              },
                              width: double.infinity,
                              text: 'الموافقه الاعلانات',
                              color: Colors.blue,
                              icon: Icons.switch_access_shortcut,
                              isVsabilIcon: true,
                            )
                          : Container(),
                      const SizedBox(
                        height: 30,
                      ),
                      isAdmin
                          ? MyButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const ReviewPlaces(),
                                  ),
                                );
                              },
                              width: double.infinity,
                              text: 'الموافقه علي المرجعات',
                              color: Colors.blue,
                              icon: Icons.switch_access_shortcut,
                              isVsabilIcon: true,
                            )
                          : Container(),
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
