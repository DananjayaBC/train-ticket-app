class Stations1 {
  int id1;
  String name1;

  Stations1({this.id1, this.name1});

  factory Stations1.fromJson(Map<String, dynamic> parsedJson) {
    return Stations1(
      id1: parsedJson["id"],
      name1: parsedJson["name"] as String,
    );
  }
}
