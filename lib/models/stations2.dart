class Stations2 {
  int id;
  String name1;

  Stations2({this.id, this.name1});

  factory Stations2.fromJson(Map<String, dynamic> parsedJson) {
    return Stations2(
      id: parsedJson["id"],
      name1: parsedJson["name"] as String,
    );
  }
}
