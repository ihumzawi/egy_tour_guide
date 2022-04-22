import 'package:egy_tour_guide/screens/screens.dart';
import 'package:egy_tour_guide/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:egy_tour_guide/palette.dart';

// ignore: must_be_immutable
class MyButton extends StatelessWidget {

   // ignore: use_key_in_widget_constructors
   MyButton({
    this.text = '',
    this.textColor = kWhite,
    this.color = kBlue,
    this.left = 0.0,
    this.right = 0.0,
    this.borderRadius = 50.0,
    this.textIcon = '',
    this.height = 60,
    this.width = 140,
    this.onPressed, this.icon = Icons.ac_unit,
   this.isVsabilIcon = false ,
  });
   bool isVsabilIcon ;
  final IconData icon ;
  final Color textColor ;
  final String text;
  final String textIcon;
  final Color color;
  final double left;
  final double right;
  final double borderRadius;
  final double height;
  final double width;
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: left, right: right),
      child: SizedBox(
        height: height,
        width: width,
        child: Material(
          borderRadius: BorderRadius.circular(borderRadius),
          color: color,
          elevation: 15,
          child: MaterialButton(
            onPressed: onPressed,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                isVsabilIcon ? Icon(icon ,color: kWhite,) : const Icon(null) ,
                Text(
                  textIcon,
                  style: const TextStyle(
                      color: kWhite, fontWeight: FontWeight.bold, fontSize: 20),
                ),
                const SizedBox(
                  width: 10,
                ),
                MyText(
                 title: text,
                  
                    color: textColor,
                    fontSize: 14,
                  ),
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}
