// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
class MyList extends StatelessWidget{
final String content ;

   const MyList({ required this.content});
  @override
  Widget build(BuildContext context) {
    return  Column(
      children:[
         ListTile(
          leading:  MyBullet(),
          title:  Text(content),
        ),

      ],
    );
  }
}

class MyBullet extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return  Container(
    height: 20.0,
    width: 20.0,
    decoration: const BoxDecoration(
    color: Colors.black,
    shape: BoxShape.circle,
  ),
  );
  }
}