import 'package:egy_tour_guide/models/models.dart';
import 'package:egy_tour_guide/screens/profile/profile_screen.dart';
import 'package:egy_tour_guide/screens/home/home_screen.dart';
import 'package:egy_tour_guide/screens/screens.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'app_data.dart';
import 'package:flutter/material.dart';
import 'widgets/widgets.dart';
import 'screens/covermorate/covernorate_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const covernorateRoute = 'CovernorateScrren';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _index = 0;

  List<Widget> screens = [
     MainScreen(),
    CovernorateScreen(),
    ProfileScreen(),
    Center(child: Text('Body 3')),
  ];
 
  getUser() {
    var user = FirebaseAuth.instance.currentUser;
    // ignore: avoid_print
    print(user!.email);
  }

  @override
  void initState() {
    print(screens[2]);
    print('--------------------------');
    getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      appBar: AppBar(
        elevation: 0,
        leading: Builder(builder: (context) {
          return IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: const Icon(
              Icons.menu,
            ),
          );
        }),
        actions: [
          IconButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.of(context)
                    .pushReplacementNamed(WelcomeScreen.welcomeRoute);
              },
              icon: const Icon(Icons.exit_to_app_outlined))
        ],
        title: const Text("دليل مصر السياحي"),
        centerTitle: true,
      ),
      body: screens[_index],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        elevation: 5,

        currentIndex: _index,
        onTap: (value) {
          setState(() {
            _index = value;
          });
        },
        items: const[
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Setting"),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Fevoret"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
      //   GridView.count(
      //   padding: const EdgeInsets.all(8),
      //   crossAxisCount: 2,
      //   childAspectRatio: 7/8,
      //   mainAxisSpacing: 8,
      //   crossAxisSpacing: 8,
      //   children:Governorate_data.map((governorateData) => CovernorateItem(
      //   governorateData.imageURL,
      //   governorateData.title
      //   )).toList() ,
      // ),
    );
  }

  Widget appbar(){
    return AppBar(
 elevation: 0,
        leading: Builder(builder: (context) {
          return IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: const Icon(
              Icons.menu,
            ),
          );
        }),
        actions: [
          IconButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.of(context)
                    .pushReplacementNamed(WelcomeScreen.welcomeRoute);
              },
              icon: const Icon(Icons.exit_to_app_outlined))
        ],
        title: const Text("دليل مصر السياحي"),
        centerTitle: true,
    );
  }
}
