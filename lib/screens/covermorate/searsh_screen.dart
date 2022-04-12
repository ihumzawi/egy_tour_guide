import 'package:egy_tour_guide/models/models.dart';
import 'package:egy_tour_guide/widgets/widgets.dart';
import 'package:flutter/material.dart';

import '../../app_data.dart';

class SearshScreen extends StatefulWidget {
  const SearshScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<SearshScreen> createState() => _SearshScreenState();
}

class _SearshScreenState extends State<SearshScreen> {
// getData() async{
//     CollectionReference coverRef = FirebaseFirestore.instance.collection("Covernorate");
//    QuerySnapshot querySnapshot= await coverRef.get();
//  List coverList = querySnapshot.docs ;
// coverList[0].title ;
//  print(coverList[0].title );
// }

  // @override
  // void initState() async{
  //   CollectionReference coverRef = FirebaseFirestore.instance.collection("covernorate");
  //  QuerySnapshot querySnapshot= await coverRef.get().then((value) {
  //    List lst1 = value.docs.toList();

  //    print('-----------------------');

  //    print( lst1);
  //  } );

  //   super.initState();
  // }
  List<Governorate> governorate = Governorate_data;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 200,
          decoration: const BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              )),
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const MyText(
                  title: "ابحث عن",
                  color: Colors.white,
                  textAlign: TextAlign.right,
                  fontSize: 25,
                ),
                const MyText(
                  title: "تجربة مميزة داخل محافظتك ..",
                  color: Colors.white,
                  textAlign: TextAlign.right,
                  fontSize: 28,
                ),
                MyTextField(
                  onChanged: (value) {
                    final suggestion = governorate.where((element) {
                      final coverTitle = element.title.toLowerCase();
                      final input = value.toString().toLowerCase();
                      return coverTitle.contains(input);
                    }).toList();
                    setState(() {
                      governorate = suggestion;
                    });
                  },
                  hint: 'ابحث',
                  textInputAction: TextInputAction.done,
                  textInputType: TextInputType.text,
                  icon: const InkWell(child: Icon(Icons.search)),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),

        Expanded(
          child: ListView.builder(
            itemCount: governorate.length,
            itemBuilder: (BuildContext context, int val) {
              final cover = governorate[val];
              return ListTile(
                leading: Image.network(
                  cover.imageURL,
                  fit: BoxFit.cover,
                  width: 50,
                  height: 50,
                ),
                title: Text(cover.title),
                //  Governorate_data[val].imageURL,
                //   Governorate_data[val].title,
                //   Governorate_data[val].countActive,
                //   Governorate_data[val].id
              );
            },
          ),
        )

        //  Expanded(
        //    child: ListView.builder(
        //        itemCount: Governorate_data.length,
        //        itemBuilder: (BuildContext context, int val) {
            //      return CovernorateItem(
            //  Governorate_data[val].imageURL,
            //   Governorate_data[val].title,
            //   Governorate_data[val].countActive,
            //   Governorate_data[val].id);
            //    },),
        //  )
      ],
    );
  }
}
