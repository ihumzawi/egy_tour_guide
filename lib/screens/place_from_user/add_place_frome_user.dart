import 'package:egy_tour_guide/screens/place_from_user/add_place.dart';
import 'package:egy_tour_guide/taps.dart';
import 'package:egy_tour_guide/widgets/my_text.dart';
import 'package:flutter/material.dart';

class AddPlaceFromUser extends StatelessWidget {
  static const pageRoute = 'addPlaseUsar';
  const AddPlaceFromUser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: Builder(builder: (context) {
            return IconButton(
              onPressed: () {
                Navigator.of(context)
                    .pushReplacementNamed(TapsScreen.tapsRoute);
              },
              icon: const Icon(Icons.arrow_back_ios),
            );
          }),
          title: const Text('اضف مكان'),
          centerTitle: true,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddPlace(),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/entertainment_place.png',
                        scale: 6,
                      ),
                      const MyText(
                        title: 'أضف مكان ترفيهي',
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                onPressed: () {

                },
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/pyramids.png',
                        scale: 6,
                      ),
                      const MyText(
                        title: 'أضف مكان ترفيهي',
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
}
