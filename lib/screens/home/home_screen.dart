import 'package:egy_tour_guide/widgets/kExpansionTile.dart';
import 'package:egy_tour_guide/widgets/my_bullet.dart';
import 'package:egy_tour_guide/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:egy_tour_guide/widgets/main_wedgets/cat_card.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.amber[100],
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
              child: const Padding(
                padding: EdgeInsets.all(30),
                child: MyText(
                  title: 'استمتع بأفضل الخدمات التى \n يقدمها البرنامج ',
                  textAlign: TextAlign.start,
                ),
              ),
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[200],
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            CatCard(
              title: 'عرووض رائعة',
              supTitle: 'assets/images/price-tag.png',
              photoPath: 'assets/images/price-tag.png',
            ),
            CatCard(
              title: 'عرووض رائعة',
              supTitle: 'assets/images/price-tag.png',
              photoPath: 'assets/images/price-tag.png',
              btomColor: Colors.blue,
              topColor: Colors.yellow,
            ),
            CatCard(
              title: 'عرووض رائعة',
              supTitle: 'assets/images/price-tag.png',
              photoPath: 'assets/images/price-tag.png',
              btomColor: Colors.blue,
              topColor: Colors.yellow,
            ),
            CatCard(
              title: 'عرووض رائعة',
              supTitle: 'assets/images/price-tag.png',
              photoPath: 'assets/images/price-tag.png',
              btomColor: Colors.blue,
              topColor: Colors.yellow,
            ),
          ],
        ),
      ),
    );
  }
}
