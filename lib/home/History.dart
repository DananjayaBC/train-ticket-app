import 'package:flutter/material.dart';

class History extends StatefulWidget {
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  Widget build(BuildContext context) {
    List<dynamic> directTrains;
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            directTrains == null
                ? Expanded(
                    child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.search,
                        color: Colors.black12,
                        size: 110,
                      ),
                      Text(
                        'No results to display',
                        style: TextStyle(
                            color: Colors.black12,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ))
                : Expanded(
                    child: ListView(
                      children: directTrains.map((trainsList) {
                        return ListTile(
                          title: Text(trainsList['startStationName']),
                          subtitle: Text(trainsList['endStationName']),
                          trailing: Text(
                              'Arivel Time-${trainsList['arrivalTimeFinalStation']}'),
                        );
                      }).toList(),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
