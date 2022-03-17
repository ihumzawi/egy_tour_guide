import 'package:flutter/material.dart';

import 'my_bullet.dart';
import 'my_text.dart';

class KExpansionTile extends StatelessWidget {
  final String titel;
  final List<Widget> buiiets ;
   KExpansionTile({required this.titel, required this.buiiets});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      leading: const Icon(Icons.info_outline_rounded),
      collapsedBackgroundColor: Colors.amber[100],
      backgroundColor: Colors.amber[100],
      title:  MyText(
        title: titel,
        fontSize: 15,
        
      ),
      children: buiiets ,
    );
  }
}


