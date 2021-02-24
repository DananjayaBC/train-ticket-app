import 'package:flutter/cupertino.dart';

class Stations1 {
  int id1;
  String name1;

 Stations1({
    @required this.id1,
    @required this.name1,
  });

  factory Stations1.fromJson(Map<String, dynamic> parsedJson) {
    return Stations1(
      id1: parsedJson["stationID"],
      name1: parsedJson["stationName"] as String,
    );
  }
}
