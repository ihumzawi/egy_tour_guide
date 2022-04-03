import 'package:egy_tour_guide/layout.dart';
import 'package:egy_tour_guide/widgets/widgets.dart';
import 'package:flutter/material.dart';
import '../../app_data.dart';

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
                .pushReplacementNamed(LayOutScreen.covernorateRoute);
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
//  Scaffold(
//       appBar: AppBar(
//         elevation: 0,
//         leading: IconButton(
//           onPressed: () {
//             Navigator.of(context)
//                 .pushReplacementNamed(LayOutScreen.covernorateRoute);
//           },
//           icon: const Icon(Icons.arrow_back_ios),
//         ),
//         title: const Text("محافظات مصر الجميلة"),
//         centerTitle: true,
//       ),
//       // get data in firebase
//       body: StreamBuilder<QuerySnapshot>(
//         stream: FirebaseFirestore.instance.collection('gover').snapshots(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           } else if (snapshot.connectionState == ConnectionState.active) {
//             if (snapshot.data!.docs.isNotEmpty) {
//               return ListView.builder(
//                 itemCount: snapshot.data!.docs.length,
//                 itemBuilder: (BuildContext context, int val) {
//                   return CovernorateItem(
//                     imageURL: snapshot.data!.docs[val]['imageUrl'],
//                     id: snapshot.data!.docs[val]['id'],
//                     title: snapshot.data!.docs[val]['name'],
//                     places: snapshot.data!.docs[val]['places'],
//                   );
//                 },
//               );
//             } else {
//               return const Center(
//                 child: MyText(title: 'ليس هناك اي اماكن يمكنك زيرتها'),
//               );
//             }
//           } else {
//             return const Center(
//               child: MyText(title: 'ليس هناك اي اماكن يمكنك زيرتها'),
//             );
//           }
//         },
//       ),
//     );