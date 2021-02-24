import 'package:flutter/cupertino.dart';

class Stations {
  int id;
  String name;

  Stations({
    @required this.id,
    @required this.name,
  });

  factory Stations.fromJson(Map<String, dynamic> parsedJson) {
    return Stations(
      id: parsedJson["stationID"] as int,
      name: parsedJson["stationName"] as String,
    );
  }
}
