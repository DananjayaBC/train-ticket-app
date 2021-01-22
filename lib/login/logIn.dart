import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:train_ticket_app/login/menuFrame.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  showExitPopup() {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Confirm'),
            content: Text('Do you want to exit?'),
            actions: <Widget>[
              RaisedButton(
                child: Text('No'),
                color: Colors.white,
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              RaisedButton(
                child: Text('Yes'),
                color: Colors.white,
                onPressed: () {
                  SystemNavigator.pop();
                },
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        showExitPopup();
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MenuFrame(),
      ),
    );
  }
}
