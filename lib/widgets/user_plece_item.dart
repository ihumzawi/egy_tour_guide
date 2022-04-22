
import 'package:egy_tour_guide/widgets/my_text.dart';
import 'package:flutter/material.dart';

class UserPlaceItem extends StatelessWidget {
  final String titel;
  final String userPlaceUrl;
  final String userImage;
  final String name;
  final String location;
  final VoidCallback selectItem ;
  
   // ignore: prefer_const_constructors_in_immutables, use_key_in_widget_constructors
   UserPlaceItem({
    required this.titel,
    required this.userPlaceUrl,
    required this.userImage,
    required this.name,
    required this.location, 
    required this.selectItem,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: selectItem,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 7,
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  child: Image.network(
                    userPlaceUrl,
                    height: 250,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ListTile(
                leading: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage(userImage),
                    ),
                  ),
                ),
                title: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText(
                      title: name,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 15, 15, 15),
                      lines: 2,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_pin,
                          size: 15,
                          color: Colors.blue,
                        ),
                        MyText(
                          title: location,
                          fontSize: 13,
                        )
                      ],
                    )
                  ],
                ),
                subtitle: MyText(
                  title: titel,
                  color: const Color.fromARGB(255, 135, 134, 134),
                  lines: 2,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
