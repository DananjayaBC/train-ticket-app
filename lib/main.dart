import 'package:flutter/material.dart';
import 'package:train_ticket_app/pages/home.dart';
import 'package:train_ticket_app/pages/loading.dart';
import 'package:train_ticket_app/pages/logIn.dart';
import 'package:train_ticket_app/pages/registration.dart';


void main() {
  runApp(MaterialApp(
          initialRoute: '/',
    routes: {
        '/': (context) =>Loading(),
      '/login': (context) => Login(),
      '/register': (context) => Registration(),
      '/home': (context) => Home(),
    },
    debugShowCheckedModeBanner: false,
  ));
}

