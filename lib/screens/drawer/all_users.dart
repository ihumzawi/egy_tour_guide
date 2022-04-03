import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:egy_tour_guide/layout.dart';
import 'package:egy_tour_guide/widgets/my_text.dart';
import 'package:flutter/material.dart';

class AllUsers extends StatelessWidget {
  const AllUsers({Key? key}) : super(key: key);

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
          title: const Text("انضم الينا حديثا"),
          centerTitle: true,
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('users').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.data!.docs.isNotEmpty) {
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (BuildContext context, index) {
                    return _userCard(
                        imageUrl: snapshot.data!.docs[index]['userImageURL'],
                        name: snapshot.data!.docs[index]['name'],
                        email: snapshot.data!.docs[index]['email']);
                  },
                );
              } else {
                return const Center(
                  child: MyText(title: 'لا يوجد مستخدمين'),
                );
              }
            } else {
              return const Center(
                child: MyText(title: 'لقد حدث خطأ'),
              );
            }
          },
        ));
  }
}

Widget _userCard(
    {required final String email,
    required final String name,
    required final String imageUrl}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Card(
      child: ListTile(
        trailing: const Text(
          '👋',
          style: TextStyle(fontSize: 40),
        ),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: Image.network(
            imageUrl,
            fit: BoxFit.fill,
          ),
        ),
        title: MyText(
          title: name.toUpperCase(),
        ),
        subtitle: MyText(
          title: email,
        ),
      ),
    ),
  );
}
