class Stations {
  int id;
  String name;

  Stations({this.id, this.name});

  factory Stations.fromJson(Map<String, dynamic> parsedJson) {
    return Stations(
      id: parsedJson["id"],
      name: parsedJson["name"] as String,
    );
  }
}
