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
                    title: 'اسم التطبيق',
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
