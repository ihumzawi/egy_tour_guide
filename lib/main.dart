import 'package:egy_tour_guide/screens/auth/forget_password.dart';
import 'package:egy_tour_guide/screens/covermorate/covernorate_guide.dart';
import 'package:egy_tour_guide/root.dart';
import 'package:egy_tour_guide/screens/screens.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_core/firebase_core.dart';

bool? isLogIn;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
 await Firebase.initializeApp();
  User? user = FirebaseAuth.instance.currentUser;
  if (user == null) {
    isLogIn = false;
  } else {
    isLogIn = true;
    // ignore: avoid_print
    print('welcome');
  }

  runApp( const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Egypt Tour Guide',
      localizationsDelegates: const [
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ],
  supportedLocales: const [
    Locale('ar', 'AE'), // English, no country code
   
  ],
      theme: ThemeData(
        focusColor: Colors.blue,
        primarySwatch: Colors.blue,
        fontFamily: 'ElMessiri',
        textTheme: ThemeData.light().textTheme.copyWith(
           headline5: const TextStyle(
            color: Colors.blue,
            fontFamily: 'ElMessiri',
            fontSize: 24,
            fontWeight: FontWeight.bold
          ),
           headline6: const TextStyle(
            color: Colors.white,
            fontFamily: 'ElMessiri',
            fontSize: 26,
            fontWeight: FontWeight.bold
          ),
          
        ),
      ),
    
     initialRoute: isLogIn! ? HomeScreen.covernorateRoute : WelcomeScreen.welcomeRoute,
      routes:{
        WelcomeScreen.welcomeRoute : (context)=>  WelcomeScreen() ,
        CreatAccount.creatRoute: (context)=> CreatAccount(),
        HomeScreen.covernorateRoute : (context)=> const HomeScreen(),
        ForgetPassword.forgetPaswword : (context) => ForgetPassword(),
        CovernorateGuide.covernorateRoute : (context) => CovernorateGuide(),
      } ,
    );
  }
}
