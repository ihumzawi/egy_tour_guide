import 'package:flutter/material.dart';
import 'my_text.dart';

class KExpansionTile extends StatelessWidget {
  final String titel;
  final List<Widget> buiiets ;
    // ignore: prefer_const_constructors_in_immutables, use_key_in_widget_constructors
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


