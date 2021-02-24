import 'package:flutter/material.dart';
import 'package:train_ticket_app/home/History.dart';

import 'package:train_ticket_app/home/profileView.dart';
import 'package:train_ticket_app/home/stationSearch.dart';

class Nav extends StatefulWidget {
  @override
  _NavState createState() => _NavState();
}

class _NavState extends State<Nav> {
  int _selectedIndex = 0;
  List<Widget> _widgetOptions = <Widget>[
    StationSearch(),
    History(),
    ProfileView(),
  ];

  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: Color.fromRGBO(106, 90, 205, 1.0),
            ),
            title: Text(
              'Home',
              style: TextStyle(
                color: Color.fromRGBO(106, 90, 205, 1.0),
              ),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.history,
              color: Color.fromRGBO(106, 90, 205, 1.0),
            ),
            title: Text(
              'History',
              style: TextStyle(
                color: Color.fromRGBO(106, 90, 205, 1.0),
              ),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              color: Color.fromRGBO(106, 90, 205, 1.0),
            ),
            title: Text(
              'Profile',
              style: TextStyle(
                color: Color.fromRGBO(106, 90, 205, 1.0),
              ),
            ),
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTap,
        selectedFontSize: 13.0,
        unselectedFontSize: 13.0,
      ),
    );
  }
}
