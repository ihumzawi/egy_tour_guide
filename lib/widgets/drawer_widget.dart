import 'package:egy_tour_guide/constant/constant.dart';
import 'package:egy_tour_guide/screens/drawer/all_users.dart';
import 'package:egy_tour_guide/screens/drawer/privacy_policy.dart';
import 'package:egy_tour_guide/screens/profile/profile_screen.dart';
import 'package:egy_tour_guide/utils.dart';
import 'package:egy_tour_guide/widgets/list_tile_item.dart';
import 'package:egy_tour_guide/widgets/my_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  String uid = '';

  void _gitUserData() {
    // ignore: unused_local_variable
    // String userUid = FirebaseAuth.instance.currentUser!.uid;
    
    final _auth =   FirebaseAuth.instance;
      User? user = _auth.currentUser;
      String _uid = user!.uid;
    setState(() {
      _uid = uid;
    });
     print("________________________"+_uid);
  }

  @override
  void initState() {
    _gitUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: Colors.blueAccent),
            child: Column(
              children: [
                Flexible(
                    child: Image.asset(
                  "assets/images/news.png",
                  scale: 1,
                )),
                const SizedBox(
                  height: 15,
                ),
                const Flexible(
                  child: MyText(
                    title: 'دليل السياحة في مصر',
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: Constant.bgColor,
            child: Column(
              children: [
                ListTileItem(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (ctx) => const ProfileScreen(),
                        ));
                  },
                  title: "الملف الشخصي",
                  supTitle: 'يضم معلومات عن فريق عمل التطبيق',
                  icon: Icons.person,
                ),
                ListTileItem(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  title: 'من نحن',
                  supTitle: 'يضم معلومات عن فريق عمل التطبيق',
                  icon: Icons.supervisor_account,
                ),
                ListTileItem(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (ctx) => const AllUsers(),
                      ),
                    );
                  },
                  title: 'انضم حديثا الينا',
                  supTitle: 'اخر المستخدمين الذين تم تسجليهم في التطبيق',
                  icon: Icons.plus_one,
                ),
                ListTileItem(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  title: 'فيم البرنامج',
                  supTitle: 'قم بتقيم التطبيق واضافه مقترحاتك للتحسين',
                  icon: Icons.rate_review,
                ),
                // FutureBuilder<DocumentSnapshot>(
                //     future: FirebaseFirestore.instance
                //         .collection('users')
                //         .doc(uid)
                //         .get(),
                //     builder: (BuildContext ctx, snapshot) {
                //       if (snapshot.connectionState == ConnectionState.waiting) {
                //       return const Center(child: CircularProgressIndicator());
                //     } else {
                //       if (snapshot.data == null) {
                //         return const Text('no comment');
                //       }
                //     }
                //      return
                        
                //        Text('kkk');
                        
                      
                     
                //     }), // المدير

                ListTileItem(
                  onTap: () {
                    Navigator.pop(context);
                    _showImageDiloge(context);
                  },
                  title: 'تواصل معنا',
                  supTitle: 'تواصل مع فريق تطوير التطبيق ',
                  icon: Icons.mail,
                ),
                ListTileItem(
                  onTap: () {
                    Navigator.of(context)
                        .pushReplacementNamed(PrivacyPolicy.privacy);
                  },
                  title: 'سايسة الخصوصية',
                  supTitle: 'سياسة الخصوصي الخاصة بطريقه عمل التطبيق',
                  icon: Icons.privacy_tip_rounded,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void _showImageDiloge(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const MyText(
              title: 'اختر طريقتك المناسبه للتواصل',
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: () => Utils.mailTo(email: 'ihumzawi@gmail.com'),
                  child: Row(
                    children: const [
                      Icon(
                        Icons.mail,
                        color: Colors.redAccent,
                      ),
                      MyText(
                        title: 'ايميل',
                        color: Colors.redAccent,
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 7,
                ),
                InkWell(
                  onTap: () => Utils.openWhatsApp(
                      numper: "0201010415988", text: 'السلام عليكم'),
                  child: Row(
                    children: const [
                      Icon(Icons.phone_android, color: Colors.green),
                      MyText(
                        title: 'عبر الواتساب',
                        color: Colors.green,
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}
