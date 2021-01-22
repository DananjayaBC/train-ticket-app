import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:train_ticket_app/login/login.dart';

class Home extends StatefulWidget {
  final User user;
  

  const Home({Key key, this.user}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  FirebaseAuth _auth = FirebaseAuth.instance;

  int _selectedItemIndex = 2;

//Exit popUp
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
      child: Scaffold(
        key: _scaffoldKey,
        bottomNavigationBar: Row(
          children: [
            buildNavBarItem(Icons.home, 0),
            buildNavBarItem(Icons.email, 1),
            buildNavBarItem(Icons.coronavirus_rounded, 2),
            buildNavBarItem(Icons.tv, 3),
            buildNavBarItem(Icons.face, 4),
          ],
        ),
        body: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                child: Text(
                  widget.user.displayName,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
              ),
              Container(
                child: OutlineButton(
                  child: Text("LogOut"),
                  onPressed: () {
                    _signOut().whenComplete(() {
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => Login()));
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildNavBarItem(IconData icon, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedItemIndex = index;
        });
      },
      child: Container(
        height: 60,
        width: MediaQuery.of(context).size.width / 5,
        decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  width: 3, color: Color.fromRGBO(106, 90, 205, 1.0))),
          gradient: LinearGradient(colors: [
            Color.fromRGBO(106, 90, 205, 1.0).withOpacity(0.3),
            Color.fromRGBO(106, 90, 205, 1.0).withOpacity(0.015),
          ], begin: Alignment.bottomCenter, end: Alignment.topCenter),

          // color: index == _selectedItemIndex ? Colors.green : Colors.white,
        ),
        child: Icon(
          icon,
          color: index == _selectedItemIndex ? Colors.black : Colors.grey,
        ),
      ),
    );
  }

  Future _signOut() async {
    await _auth.signOut();
  }
}
