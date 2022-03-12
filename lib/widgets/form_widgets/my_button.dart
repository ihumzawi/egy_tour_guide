import 'package:egy_tour_guide/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:egy_tour_guide/palette.dart';

class MyButton extends StatelessWidget {

   MyButton({
    Key? key,
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
  }) : super(key: key);
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
                isVsabilIcon ? Icon(icon ,color: kWhite,) : Icon(null) ,
                Text(
                  textIcon,
                  style: const TextStyle(
                      color: kWhite, fontWeight: FontWeight.bold, fontSize: 20),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  text,
                  style:  TextStyle(
                    color: textColor,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
