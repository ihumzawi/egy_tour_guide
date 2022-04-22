import 'package:flutter/material.dart';

import 'package:egy_tour_guide/palette.dart';

class MyText extends StatelessWidget {
  const MyText(
      {Key? key,
      this.title = '',
      this.fontSize = 17.0,
      this.fontWeight = FontWeight.normal,
      this.color = kBlack,
      this.textAlign = TextAlign.right, this.lines = 2})
      : super(key: key);
  final TextAlign? textAlign;
  final String title;
  final Color color;
  final double fontSize;
  final FontWeight fontWeight;
  final int lines ;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3),
      child: Text(
        title,
        overflow: TextOverflow.ellipsis,
        maxLines: lines,
        
        textAlign: textAlign,
        style:
            TextStyle(fontSize: fontSize, fontWeight: fontWeight, color: color,   fontFamily: 'ElMessiri'),
      ),
    );
  }
}
