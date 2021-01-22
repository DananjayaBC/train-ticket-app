import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:train_ticket_app/login/logIn.dart';
import 'package:train_ticket_app/home/home.dart';
import 'package:train_ticket_app/splashScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/',
    routes: {
      '/': (context) => SplashScreen(),
      '/login': (context) => Login(),
      '/home': (context) => Home(),
    },
    title: 'Train app',
    theme: ThemeData(
      primaryColor: Colors.white,
      primarySwatch: Colors.blue,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    ),
  ));
}


// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   WidgetsFlutterBinding.ensureInitialized();
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   String email = prefs.getString("email");
//   runApp(MaterialApp(
//     debugShowCheckedModeBanner: false,
//     home: email == null ? Login() : Home(),
//     title: 'Train app',
//     theme: ThemeData(
//       primaryColor: Colors.white,
//       primarySwatch: Colors.blue,
//       visualDensity: VisualDensity.adaptivePlatformDensity,
//     ),
//   ));
// }
