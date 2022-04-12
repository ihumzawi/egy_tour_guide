import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:egy_tour_guide/widgets/my_text.dart';
import 'package:flutter/material.dart';

// ignore: use_key_in_widget_constructors
class UserPlaceItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Card(
        elevation: 8.0,
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
        child: ListTile(
          onTap: () {},
          onLongPress: () {
            // ignore: avoid_single_cascade_in_expression_statements
            AwesomeDialog(
              context: context,
              dialogType: DialogType.WARNING,
              animType: AnimType.BOTTOMSLIDE,
              //  title: 'هل انت واثق من تسجيل الخروج ؟',
              desc: 'هل انت واثق من انك تريد حذف المكان ؟',
              btnCancelOnPress: () {},
              btnOkOnPress: () {},
            )..show();
          },
          title: Image.network(
            "https://firebasestorage.googleapis.com/v0/b/egy-guide.appspot.com/o/userImages%2FNEXfVevQo1VCWyGs9tQfZSxznzn2.jpg?alt=media&token=c5fd37c6-0554-4dec-8be1-c69e42052d17",
            fit: BoxFit.cover,
          ),
          subtitle: ListTile(
            leading: Container(
              height: 40,
              width: 40,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage(
                      "https://firebasestorage.googleapis.com/v0/b/egy-guide.appspot.com/o/userImages%2FNEXfVevQo1VCWyGs9tQfZSxznzn2.jpg?alt=media&token=c5fd37c6-0554-4dec-8be1-c69e42052d17"),
                ),
              ),
            ),
            title: Row(
              children: [
                const MyText(
                  title: 'Titel',
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 15, 15, 15),
                  lines: 1,
                ),
                const SizedBox(
                  width: 5,
                ),
                Row(
                  children: const [
                    Icon(
                      Icons.location_pin,
                      size: 15,
                      color: Colors.blue,
                    ),
                    MyText(
                      title: 'الدقاهلية',
                      fontSize: 13,
                    )
                  ],
                )
              ],
            ),
            subtitle: MyText(
              title: 'Titel',
              color: Color.fromARGB(255, 135, 134, 134),
              lines: 2,
            ),
          ),
        ),
      ),
    );
  }
}
