import 'package:egy_tour_guide/widgets/my_text.dart';
import 'package:flutter/material.dart';

class CatCard extends StatelessWidget {
  final String title;
  final String supTitle;
  final Color topColor;
  final Color btomColor;
  final String photoPath;
  final VoidCallback onTap;
  CatCard(
      {required this.title,
      required this.photoPath,
      required this.supTitle,
      this.btomColor = Colors.purple,
      this.topColor = Colors.pink,
      required this.onTap});
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            color: Colors.white,
            child: Row(
              children: <Widget>[
                Container(
                  decoration: const BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(16),
                        topRight: Radius.circular(16),
                      )),
                  width: 120,
                  height: 120,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      photoPath,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      MyText(
                        title: title,
                        fontSize: 20,
                    fontWeight: FontWeight.bold,
                        
                      ),
                      MyText(
                        title: supTitle,
                        fontSize: 14,
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.arrow_forward_ios, color: Colors.blue),
                const SizedBox(width: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
