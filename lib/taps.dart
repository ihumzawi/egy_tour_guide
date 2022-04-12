import 'package:egy_tour_guide/screens/favourite/favorit.dart';
import 'package:flutter/material.dart';
import 'screens/home/home_screen.dart';

class TapsScreen extends StatefulWidget {
  static const String tapsRoute = 'taps' ;
  const TapsScreen({Key? key}) : super(key: key);

  @override
  State<TapsScreen> createState() => _TapsScreenState();
}

class _TapsScreenState extends State<TapsScreen> {
  int screenIndex = 0;
  List<Widget> screens = [
    MainScreen(),
    const FavoritScreen(),
  ];
  _selectScreen(int index) {
    setState(() {
      screenIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: screenIndex,
        backgroundColor: Colors.blue,
        iconSize: 30.0,
        selectedItemColor: Colors.amber,
        unselectedItemColor: Colors.white,
        selectedLabelStyle: const TextStyle(
          fontFamily: 'ElMessiri',
          fontSize: 15.0,
        ),
        unselectedLabelStyle: const TextStyle(
          fontFamily: 'ElMessiri',
          fontSize: 15.0,
        ),
        onTap: _selectScreen,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.dashboard), label: 'التصنيفات'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'المفضلة'),
        ],
      ),
      body: screens[screenIndex],
    );
  }
}
