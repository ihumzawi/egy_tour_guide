import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:egy_tour_guide/admin_forms/add_covernorate.dart';
import 'package:egy_tour_guide/constant/constant.dart';
import 'package:egy_tour_guide/screens/covermorate/covernorate_screen.dart';
import 'package:egy_tour_guide/widgets/kExpansionTile.dart';
import 'package:egy_tour_guide/widgets/my_bullet.dart';
import 'package:egy_tour_guide/widgets/my_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:egy_tour_guide/widgets/main_wedgets/cat_card.dart';

class MainScreen extends StatefulWidget {
  MainScreen({Key? key}) : super(key: key);
  String name = '';

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _auth = FirebaseAuth.instance;
  bool _isLoding = false;

  String name = '';
  String imageUrl = '';
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
          name = userDoc.get('name');
          imageUrl = userDoc.get('userImageURL');
        });
        User? user = _auth.currentUser;
        String _uid = user!.uid;
      }
    } catch (err) {
      print('------------------errer ------------');
    } finally {
      setState(() {
        _isLoding = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constant.bgColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Constant.bgColor,
              child: KExpansionTile(
                titel: 'نصائح للجمهور بشأن مرض فيروس كورونا (كوفيد-19)',
                buiiets: [
                  MyList(
                      content:
                          'ابتعد مسافة متر واحد على الأقل عن الآخرين للحد من مخاطر الإصابة بالعدوى عندما يسعلون أو يعطسون أو يتكلمون. ابتعد مسافة أكبر من ذلك عن الآخرين عندما تكون في أماكن مغلقة. كلما ابتعدت مسافة أكبر، كان ذلك أفضل.'),
                  MyList(
                      content:
                          'اجعل من ارتداء الكمامة عادة عندما تكون مع أشخاص آخرين. إنّ استعمال الكمامات وحفظها وتنظيفها والتخلص منها بشكل سليم أمر ضروري لجعلها فعالة قدر الإمكان.'),
                  Center(
                    child: Column(
                      children: [
                        const Text(
                            'لمذيد من التفاصيل يرجي زيارة الرابط التالي'),
                        TextButton(
                          onPressed: () {},
                          child: const Text(
                              'https://www.who.int/ar/emergencies/diseases/novel-coronavirus-2019/advice-for-public'),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: Column(
                  children: [
                    MyText(
                      title: 'مرحبا 👋 ${name.toString()} ',
                      textAlign: TextAlign.start,
                      fontSize: 27,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                    const MyText(
                      title: ' استمتع بأفضل الخدمات التى  يقدمها البرنامج ',
                      textAlign: TextAlign.start,
                      fontSize: 24,
                      lines: 1,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),
              ),
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Constant.bgColor,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            CatCard(
              title: 'اضافة محافظة',
              supTitle:
                  ' استكشف افضل الاماكن السياحية داخل مصر واعرف اهم الماكن المجاورة لمنطقتك',
              photoPath: "assets/images/exploration.png",
              onTap: () {
                Navigator.of(context)
                    .pushReplacementNamed(AddCover.addCover);
              },
            ),
            CatCard(
              title: 'استكشف المحافظات',
              supTitle:
                  ' استكشف افضل الاماكن السياحية داخل مصر واعرف اهم الماكن المجاورة لمنطقتك',
              photoPath: "assets/images/exploration.png",
              onTap: () {
                Navigator.of(context)
                    .pushReplacementNamed(CovernorateScreen.covernorateRoute);
              },
            ),
            CatCard(
              title: 'عرووض رائعة',
              supTitle:
                  'استمتع بأفضل العروض الحصرية الموجوده داخل التطبيق المحدثة بشكل دائم',
              photoPath: "assets/images/offers.png",
              btomColor: Colors.blue,
              topColor: Colors.yellow,
              onTap: () {},
            ),
            CatCard(
              title: 'اخبار اقتصادية وسياحية',
              supTitle: 'اخر الاخبار والاحداث الاقتصادية والسياحية داخل مصر',
              photoPath: "assets/images/news.png",
              btomColor: Colors.blue,
              topColor: Colors.yellow,
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
