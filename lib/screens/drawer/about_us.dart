import 'package:egy_tour_guide/screens/home/home_screen.dart';
import 'package:egy_tour_guide/widgets/my_text.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AboutUs extends StatelessWidget {
  List<String> cells = ['م', 'الاســــــــــــــــــــــــم :'];

  AboutUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const MyText(
              color: Colors.white,
              title: 'من نحن',
              lines: 1,
            ),
            leading: IconButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MainScreen(),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                )),
          ),
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: MyText(
                          title: 'فكرة المشروع الكتالوج الإلكتروني للسياحة الداخلية :',
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      const MyText(
                        title:
                            '''
يطمح فريق العمل المكون للمشروع تحت رعاية معهد الدلتا العالي للحسابات والنظم الإدارية أن نقوم بعمل منصة متكاملة وكتالوج يضم كل ما يخص قطاع السياحة الداخلية في مصر ،  
إنشاء منصة إلكترونية متكاملة تتمثل في انشاء تطبيق الكتروني يعمل على جميع المنصات الممكنة ، الهواتف الذكية Android , IOS أو تطبيقات سطح المكتب لأنظمة التشغيل المكتبية Window ,Linux ,Mac Os أو العرض على الويب .
حيث يقوم بتقديم العديد من الخدمات لمستخدم التطبيق يقوم بمثابة حلقة الوصل بين المستخدم وكافة  سبل السياحة والترقية حيث يقوم النظام بتقديم المعلومات عن جميع الاماكن السياحيه وتصنيفها حسب مكان التواجد مما يسهل عملية الوصول إليها  
توفير عدد كبير من العروض السياحية التي تظهر للمستخدم بالنسبة لمكانة الجغرافي ، القدرة على تقييم تجربة في المكان السياحي من داخل التطبيق و والإعجاب به وحفظ معلومات داخل الملف الشخصي الخاص بالمستخدم 
كما يوفر إمكانية نشر تجربة المستخدم Review  : التي من خلالها يقوم المستخدم بنشر صور للمكان الترفيهي أو السياحي الذي يريد مشاركته مع المستخدمين الآخرين داخل التطبيق 
يوفر النظام اخر الاخبار و الاحداث الاقتصادية والسياحية للمستخدم من خلال قسم خاص بالاخبار ،  وايضا يمكن للمعلنين التواصل مع مدير النظام لعرض الإعلانات و العروض الخاصة داخل النظام  ''',
                          lines: 40,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: MyText(
                          title: 'فريق عمل المشروع ',
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      
                      Table(
                        border: TableBorder.all(),
                        columnWidths: const {
                          0: FractionColumnWidth(.25),
                        },
                        children: [
                          kTableRow(cells, isHeadr: true),
                          kTableRow(['1', 'محمد السعيد السعيد حمزة']),
                          kTableRow(['2', 'اسراء جمال ابو الفتوح احمد العشري']),
                          kTableRow(['3', 'اسراء خطاب هلال خطاب صالح']),
                          kTableRow(['4', 'ايمان محمد علي فتحي جاد']),
                          kTableRow(['6', 'محمد ابراهيم ابراهيم سيف']),
                          kTableRow(['7', 'سارة خالد محمد احمد']),
                          kTableRow(['8', 'اية محمد السعيد حامد سعد']),
                          kTableRow(['9', 'سعاد رمضان عبد الحميد الشربيني']),
                          kTableRow(['10', 'اسماء محمد محمود السباعي']),
                          kTableRow(['11', 'كريم طارق عيد محمد']),
                          kTableRow(['11', 'محمد الشوادفي احمد ']),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 50,
                )
              ],
            ),
          )),
    );
  }

  TableRow kTableRow(List<String> cells, {bool isHeadr = false}) {
    return TableRow(
        children: cells
            .map((cell) => Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Center(
                      child: MyText(
                    title: cell,
                    fontWeight: isHeadr ? FontWeight.bold : FontWeight.normal,
                  )),
                ))
            .toList());
  }
}
