import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:egy_tour_guide/constant/constant.dart';
import 'package:egy_tour_guide/screens/ads/all_ads.dart';
import 'package:egy_tour_guide/screens/covermorate/covernorate_screen.dart';
import 'package:egy_tour_guide/utils.dart';
import 'package:egy_tour_guide/widgets/my_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:egy_tour_guide/widgets/main_wedgets/cat_card.dart';
import '../drawer/main_drawer/drawer_widget.dart';
import '../place_from_user/add_place_frome_user.dart';
import '../place_from_user/all_places_user.dart';

// ignore: must_be_immutable
class MainScreen extends StatefulWidget {
  MainScreen({Key? key}) : super(key: key);
  String name = '';

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _auth = FirebaseAuth.instance;
  // ignore: unused_field
  bool _isLoding = false;

  String name = '';
  String imageUrl = '';
  // ignore: prefer_final_fields, unused_field
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
        // ignore: unused_local_variable
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
      drawer: const DrawerWidget(),
      appBar: AppBar(
        elevation: 0,
        leading: Builder(builder: (context) {
          return IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: const Icon(
              Icons.menu,
            ),
          );
        }),
        title: const Text("دليل مصر السياحي"),
        centerTitle: true,
      ),
      backgroundColor: Constant.bgColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.amber[70],
              child: ExpansionTile(
                leading: const Icon(Icons.info_outline_rounded),
                title: const MyText(
                  title: '''نصائح للجمهور بشأن مرض فيروس كورونا (كوفيد-19)''',
                  fontSize: 14,
                ),
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        kMyText(
                            title:
                                'ما الذي ينبغي عمله لحماية نفسك والآخرين من كوفيد-19',
                            text:
                                '''ابتعد مسافة متر واحد على الأقل عن الآخرين للحد من مخاطر الإصابة بالعدوى عندما يسعلون أو يعطسون أو يتكلمون. ابتعد مسافة أكبر من ذلك عن الآخرين عندما تكون في أماكن مغلقة. كلما ابتعدت مسافة أكبر، كان ذلك أفضل.
اجعل من ارتداء الكمامة عادة عندما تكون مع أشخاص آخرين. إنّ استعمال الكمامات وحفظها وتنظيفها والتخلص منها بشكل سليم أمر ضروري لجعلها فعالة قدر الإمكا'''),
                        const SizedBox(
                          height: 20,
                        ),
                        kMyText(
                            title:
                                'فيما يلي المعلومات الأساسية عن كيفية ارتداء الكمامة:',
                            text:
                                '''نظّف يديك قبل أن ترتدي الكمامة، وقبل خلعها وبعده.
تأكد من أنها تغطي أنفك وفمك وذقنك.
عندما تخلع الكمامة، احفظها في كيس بلاستيكي نظيف، واحرص يومياً على غسلها إذا كانت كمامة قماشية أو التخلّص منها في صندوق النفايات إذا كانت كمامة طبية.
لا تستعمل الكمامات المزودة بصمامات.'''),
 const SizedBox(
                          height: 20,
                          
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const MyText(
                              title:
                                  'يمكنك الاتطلاع علي جميع الارشادات علي موقع منظمة الصحة العالمية ',
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                            TextButton(
                              onPressed: () {
                                Utils.urlLuncher(url: 'https://www.who.int/ar');
                              },
                              child: const MyText(
                                title: 'www.who.int/ar',
                                color: Colors.blue,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Stack(
                          children: [
                            MyText(
                              title:
                                  ' مرحبا  👋 ${name.toString()} استمتع بأفضل الخدمات التى  يقدمها البرنامج  ',
                              textAlign: TextAlign.start,
                              fontSize: 27,
                              color: Colors.blue,
                              lines: 3,
                              fontWeight: FontWeight.bold,
                            ),
                            Image.asset('assets/images/egypt_header.png'),
                          ],
                        ),
                      ),
                    )
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
              title: "اضف تجربتك",
              supTitle:
                  ' استكشف افضل الاماكن السياحية داخل مصر واعرف اهم الماكن المجاورة لمنطقتك',
              photoPath: "assets/images/add.png",
              onTap: () {
                // Navigator.of(context)
                //     .pushReplacementNamed(AddItem.addCover);
                Navigator.of(context)
                    .pushReplacementNamed(AddPlaceFromUser.pageRoute);
              },
            ),
            CatCard(
              title: 'ترشيحات المستخدمين',
              supTitle:
                  'استجشف تجربة جديده من خلال التعرف علي تجربه احد المستخدين للبرنامج',
              photoPath: "assets/images/reviews.png",
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AllPlacesUser(),
                  ),
                );
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
            // CatCard(
            //   title: 'عرووض رائعة',
            //   supTitle:
            //       'استمتع بأفضل العروض الحصرية الموجوده داخل التطبيق المحدثة بشكل دائم',
            //   photoPath: "assets/images/offers.png",
            //   btomColor: Colors.blue,
            //   topColor: Colors.yellow,
            //   onTap: () {
            //       Navigator.pushReplacement(
            //       context,
            //       MaterialPageRoute(
            //         builder: (context) => const AddAdsScreen(),
            //       ),
            //     );
            //   },
            // ),
            CatCard(
              title: 'عرووض رائعة',
              supTitle:
                  'استمتع بأفضل العروض الحصرية الموجوده داخل التطبيق المحدثة بشكل دائم',
              photoPath: "assets/images/offers.png",
              btomColor: Colors.blue,
              topColor: Colors.yellow,
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AllAdsScreen(),
                  ),
                );
              },
            ),
            // CatCard(
            //   title: 'من نحن ',
            //   supTitle: 'معلومات عن المشروع ',
            //   photoPath: "assets/images/news.png",
            //   btomColor: Colors.blue,
            //   topColor: Colors.yellow,
            //   onTap: () {
            //      Navigator.pushReplacement(
            //       context,
            //       MaterialPageRoute(
            //         builder: (context) =>  AboutUs(),
            //       ),
            //     );
            //   },
            // ),
            const SizedBox(
              height: 50,
            )
          ],
        ),
      ),
    );
  }

  Column kMyText({required String text, required String title}) {
    return Column(
      children: [
        MyText(
          title: title,
          fontWeight: FontWeight.bold,
          fontSize: 13,
        ),
        MyText(
          title: text,
          fontWeight: FontWeight.normal,
          lines: 50,
          fontSize: 13,
        ),
      ],
    );
  }
}
