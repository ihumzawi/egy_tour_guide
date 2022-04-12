import 'package:egy_tour_guide/widgets/widgets.dart';
import 'package:flutter/material.dart';
import '../../app_data.dart';
import '../../taps.dart';

class CovernorateScreen extends StatefulWidget {
  static const covernorateRoute = '/CovernorateScreen';
  const CovernorateScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<CovernorateScreen> createState() => _CovernorateScreenState();
}

class _CovernorateScreenState extends State<CovernorateScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context)
                .pushReplacementNamed(TapsScreen.tapsRoute);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: const Text("محافظات مصر الجميلة"),
        centerTitle: true,
      ),
      // get data in firebase
      body:  GridView(
      padding: const EdgeInsets.all(10),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 250,
        childAspectRatio: 7 / 8,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
      children: Governorate_data.map(
        (categoryData) => CovernorateItem(
          id : categoryData.id,
          title :categoryData.title,
         imageURL: categoryData.imageURL,
        ),
      ).toList(),
    )
    );
  }
}
