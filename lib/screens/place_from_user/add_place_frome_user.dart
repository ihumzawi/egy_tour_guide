import 'package:egy_tour_guide/screens/place_from_user/add_place.dart';
import 'package:egy_tour_guide/taps.dart';
import 'package:egy_tour_guide/widgets/my_text.dart';
import 'package:flutter/material.dart';

import '../../admin/add_covernorate.dart';
import '../ads/add_ads.dart';

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
           
            kElevatedButton(
              context,
              imagePath: 'assets/images/entertainment_place.png',
              title: 'أضف مكان ترفيهي',
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddPlace(),
                  ),
                );
              },
            ),
            const SizedBox(
              height: 20,
            ),
            kElevatedButton(
              context,
              imagePath: 'assets/images/pyramids.png',
              title: 'اضف مكان داخل المحافظة',
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddItem(),
                  ),
                );
              },
            ),
            const SizedBox(
              height: 20,
            ),
            kElevatedButton(
              context,
              imagePath: 'assets/images/ads.png',
              title: 'اضف اعلان ',
              onPressed:() {
                  Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddAdsScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Center kElevatedButton(BuildContext context,
      {required String imagePath,
      required String title,
      required VoidCallback onPressed}) {
    return Center(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        onPressed: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SizedBox(
            width: 150,
            child: Column(
              children: [
                Image.asset(
                  imagePath,
                  scale: 6,
                ),
                MyText(
                  title: title,
                  color: Colors.white,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
