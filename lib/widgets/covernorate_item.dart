
import 'package:egy_tour_guide/screens/covermorate/covernorate_guide.dart';
import 'package:flutter/material.dart';

class CovernorateItem extends StatelessWidget {
  final String imageURL;
  final String title;
  final String places;
  final String id ;
  void selectedITem(BuildContext ctx){
   Navigator.of(ctx).pushNamed(CovernorateGuide.covernorateRoute,
   arguments: {
     'id' : id,
     'title' : title,
   }) ;  
  }
// ignore: use_key_in_widget_constructors
   CovernorateItem({required this.imageURL, required this.title, required this.places, required this.id,} );
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
      child: InkWell(
        onTap:(){
          selectedITem(context) ;
        },
        splashColor: Theme.of(context).primaryColor,
       
        child: Stack(
          alignment: Alignment.bottomRight,
          children: [
            ShaderMask(
              blendMode: BlendMode.darken,
              child: Container(
                width: double.infinity,
                alignment: Alignment.bottomRight,
                child: Image.network(
                  imageURL,
                  fit: BoxFit.cover,
                  height: 190,
                  width: double.infinity,
                ),
              ),
              shaderCallback: (ract) {
                // ignore: prefer_const_constructors
                return LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.center,
                  colors: const [
                    Colors.black54,
                    Colors.transparent,
                  ],
                ).createShader(ract);
              },
            ),
            ListTile(
              title: Text(title, style: Theme.of(context).textTheme.headline6),
              subtitle: Text(' عدد الاماكن في المحافظة ${places.toString()}',
                  style: const TextStyle(color: Colors.white, fontSize: 20)),
            ),
          ],
        ),
      ),
    );
  }
}
