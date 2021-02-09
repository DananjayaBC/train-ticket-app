import 'package:flutter/material.dart';
import 'dart:async';
import 'package:dropdownfield/dropdownfield.dart';

class StationSearch extends StatefulWidget {
  @override
  _StationSearchState createState() => _StationSearchState();
}

class _StationSearchState extends State<StationSearch> {
  @override
  void initState() {
    super.initState();
  }

  String station_id;
  List<String> station = [
    "Mirigama",
    "Rajadahana",
    "Ganegoda",
    "Pallewela",
    "Kenawala",
    "Wadurawa",
    "Veyandoda",
    "Gampaha",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(245, 50, 111, 1.0),
        title: Center(
          child: Text("Buy Tickets"),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(15.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              DropDownField(
                onValueChanged: (dynamic value) {
                  station_id = value;
                },
                value: station_id,
                required: false,
                hintText: 'I\'m at',
                labelText: 'Station Name',
                items: station,
                strict: true,
              ),
              Divider(height: 10.0, color: Theme.of(context).primaryColor),
              DropDownField(
                onValueChanged: (dynamic value) {
                  station_id = value;
                },
                value: station_id,
                required: false,
                hintText: 'I want to go to',
                labelText: 'Station Name',
                items: station,
                strict: false,
              ),
            ]),
      ),
    );
  }
}
