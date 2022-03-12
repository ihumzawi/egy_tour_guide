import 'package:egy_tour_guide/widgets/my_text.dart';
import 'package:flutter/material.dart';

class CatCard extends StatelessWidget {
  final String title;
  final String supTitle;
  final Color topColor;
  final Color btomColor;
  final String photoPath;
  CatCard({
    required this.title,
    required this.photoPath,
    required this.supTitle,
    this.btomColor  = Colors.purple,
    this.topColor =   Colors.pink 

  });
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5 , horizontal: 10),
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyText(
                    title: title,
                    color: Colors.white,
                    fontSize: size.width / 22,
                    textAlign: TextAlign.right,
                  ),
                  MyText(
                    title: supTitle,
                    color: Colors.white,
                    fontSize: size.width / 35,
                  ),
                ],
              ),
              Image.asset(photoPath)
            ],
          ),
        ),
        height: size.width / 4,
        width: size.width * 2,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment
                .bottomRight, // 10% of the width, so there are ten blinds.
            colors: <Color>[topColor, btomColor], // red to yellow
            tileMode: TileMode.repeated, // repeats the gradient over the canvas
          ),
        ),
      ),
    );
  }
}
