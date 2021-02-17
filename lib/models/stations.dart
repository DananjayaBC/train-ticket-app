class Stations {
  int id;
  String name;

  Stations({this.id, this.name});

  factory Stations.fromJson(Map<String, dynamic> parsedJson) {
    return Stations(
      id: parsedJson["stationID"],
      name: parsedJson["stationName"] as String,
    );
  }
}
