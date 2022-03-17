import 'package:egy_tour_guide/models/models.dart';
import 'package:egy_tour_guide/screens/profile/profile_screen.dart';
import 'package:egy_tour_guide/screens/home/home_screen.dart';
import 'package:egy_tour_guide/screens/screens.dart';
import 'package:egy_tour_guide/widgets/drawer_widget.dart';
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
  int _index = 1;

  List<Widget> screens = [
    CovernorateScreen(),
     MainScreen(),
    
    ProfileScreen(),
   // Center(child: Text('Body 3')),
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
      drawer: DrawerWidget(),
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
          BottomNavigationBarItem(icon: Icon(Icons.favorite,color:  Colors.redAccent,), label: "المفضلة" , ),
          BottomNavigationBarItem(icon: Icon(Icons.home,color:  Colors.greenAccent,), label: "الرئسية"),
          
          BottomNavigationBarItem(icon: Icon(Icons.person,color:  Colors.blueAccent,), label: "الصفحة الشخصية"),
        ],
          selectedLabelStyle: const TextStyle( fontFamily: 'ElMessiri'),
          unselectedLabelStyle: const TextStyle(fontSize: 15 , fontFamily: 'ElMessiri'),
          selectedItemColor: Colors.blueAccent ,
          unselectedItemColor: Colors.grey,
          selectedFontSize: 18,

      ),
     
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
