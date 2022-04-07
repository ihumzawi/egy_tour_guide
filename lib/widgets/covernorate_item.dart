import 'package:egy_tour_guide/screens/covermorate/covernorate_place_item.dart';
import 'package:flutter/material.dart';

class CovernorateItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageURL;

  void selectedITem(BuildContext ctx) {
   
    Navigator.push(
      ctx,
      MaterialPageRoute(
        builder: (ctx) => CovernoratePlaceItem(
          categoryId: id,
          categoryTitel: title,
        ),
      ),
      
    );
  }

  // ignore: use_key_in_widget_constructors
  const CovernorateItem({
    required this.imageURL,
    required this.title,
    required this.id,
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectedITem(context),
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(15),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.network(
              imageURL,
              height: 250,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            alignment: Alignment.center,
            child: Text(
              title,
              style: Theme.of(context).textTheme.headline6,
            ),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.4),
              borderRadius: BorderRadius.circular(15),
            ),
          )
        ],
      ),
    );
  }
}
