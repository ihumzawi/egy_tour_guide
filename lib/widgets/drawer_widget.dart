import 'package:egy_tour_guide/constant/constant.dart';
import 'package:egy_tour_guide/screens/drawer/all_users.dart';
import 'package:egy_tour_guide/widgets/list_tile_item.dart';
import 'package:egy_tour_guide/widgets/my_text.dart';
import 'package:flutter/material.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({Key? key}) : super(key: key);

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
                        builder: (ctx) => AllUsers(),
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
                ListTileItem(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  title: 'تواصل معنا',
                  supTitle: 'تواصل مع فريق تطوير التطبيق ',
                  icon: Icons.mail,
                ),
                ListTileItem(
                  onTap: () {
                    Navigator.pop(context);
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
}
