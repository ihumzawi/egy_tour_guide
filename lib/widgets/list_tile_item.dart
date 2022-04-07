import 'package:egy_tour_guide/widgets/my_text.dart';
import 'package:flutter/material.dart';

class ListTileItem extends StatelessWidget {
  final VoidCallback onTap;
  final String title ;
  final String supTitle ;
  final IconData icon ;
  // ignore: use_key_in_widget_constructors
  const ListTileItem({
    required this.onTap, required this.title, required this.icon, required this.supTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10 , horizontal: 8),
      child: ListTile(
        title:  MyText(
          title: title,
          lines: 1,
          fontSize: 15,
          fontWeight: FontWeight.bold,
          color: Colors.blueAccent,
        ),
        onTap: onTap,trailing: const Icon(Icons.arrow_back_ios_new,color: Colors.amber,),
        leading: IconButton(icon: Icon(icon ,color: Colors.blueAccent,)  , onPressed: (){}, ),
        subtitle: MyText(
          title: supTitle,
          lines: 1,
          fontSize: 12,
          color: const Color.fromARGB(255, 128, 128, 128),
          
        ),
        
      ),
    );
  }
}

// Navigator.pop(context);