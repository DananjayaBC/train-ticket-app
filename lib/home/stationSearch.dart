import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:train_ticket_app/models/stations.dart';
import 'package:train_ticket_app/models/stations2.dart';

import 'dart:convert';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:convert/convert.dart';

class StationSearch extends StatefulWidget {
  final dio =
      Dio(BaseOptions(baseUrl: 'http://api.lankagate.gov.lk:8280', headers: {
    'Accept': 'application/json',
    'Authorization': 'Bearer 64b3fb8c-8619-3d2a-959f-6cc1f68839d1'
  }));
  @override
  _StationSearchState createState() => _StationSearchState();
}

class _StationSearchState extends State<StationSearch> {
  AutoCompleteTextField searchTextField;
  AutoCompleteTextField searchTextField1;
  GlobalKey<AutoCompleteTextFieldState<Stations>> key = new GlobalKey();
  GlobalKey<AutoCompleteTextFieldState<Stations1>> key1 = new GlobalKey();

  static List<Stations> stations = new List<Stations>();
  static List<Stations1> stations1 = new List<Stations1>();
  bool loading = true;

  void getStations() async {
    try {
      final response = await http.get(
          "https://onlinetrainticket-17091-default-rtdb.firebaseio.com/train/stationList.json");
      if (response.statusCode == 200) {
        stations = loadStations(response.body);
        print('Stations: ${stations.length}');
        setState(() {
          loading = false;
        });
      } else {
        print("Error getting stations.");
      }
    } catch (e) {}
  }

  void getStations1() async {
    try {
      final response = await http.get(
          "https://onlinetrainticket-17091-default-rtdb.firebaseio.com/train/stationList.json");
      if (response.statusCode == 200) {
        stations1 = loadStations1(response.body);
        print('Stations: ${stations1.length}');
        setState(() {
          loading = false;
        });
      } else {
        print("Error getting stations.");
      }
    } catch (e) {}
  }

  static List<Stations> loadStations(String jsonString) {
    final parsed = json.decode(jsonString).cast<Map<String, dynamic>>();
    return parsed.map<Stations>((json) => Stations.fromJson(json)).toList();
  }

  static List<Stations1> loadStations1(String jsonString) {
    final parsed = json.decode(jsonString).cast<Map<String, dynamic>>();
    return parsed.map<Stations1>((json) => Stations1.fromJson(json)).toList();
  }

  @override
  void initState() {
    getStations();
    getStations1();
    super.initState();
  }

  Widget row(Stations stations) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              stations.name,
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.black,
              ),
            ),
            Text(
              stations.id.toString(),
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget row1(Stations1 stations1) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              stations1.name1,
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.black,
              ),
            ),
            Text(
              stations1.id1.toString(),
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  final _formKey = GlobalKey<FormState>();

  var _autoValidate = false;
  var _search;
  var _search1;
  List<dynamic> _directTrains;

  void searchTrain(String query) async {
    final response = await widget.dio.get(
        "/railway/1.0/train/searchTrain?startStationID=$_search&endStationID=$_search1&startTime=00:00:00&endTime=23:59:00&lang=en&searchDate=2021-02-21");
    setState(() {
      _directTrains = response.data['RESULTS']['directTrains']['trainsList'];
    });
  }

  @override
  Widget build(BuildContext context) {
    var myController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Train Search")),
        backgroundColor: Colors.red,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Form(
              key: _formKey,
              autovalidate: _autoValidate,
              child: Column(
                children: [
                  loading
                      ? CircularProgressIndicator()
                      : searchTextField = AutoCompleteTextField<Stations>(
                          key: key,
                          clearOnSubmit: false,
                          suggestions: stations,
                          style: TextStyle(color: Colors.black, fontSize: 20.0),
                          decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 20.0),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black)),
                            hintText: 'I am At',
                            hintStyle:
                                TextStyle(color: Colors.grey.withOpacity(1.0)),
                            focusColor: Colors.red,
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.red[600]),
                            ),
                          ),
                          itemFilter: (item, query) {
                            return item.name
                                .toLowerCase()
                                .startsWith(query.toLowerCase());
                          },
                          itemSorter: (a, b) {
                            return a.name.compareTo(b.name);
                          },
                          itemSubmitted: (item) {
                            searchTextField.textField.controller.text =
                                item.name;
                            _search = item.id.toString();
                          },
                          itemBuilder: (context, item) {
                            return row(item);
                          },
                          controller: myController,
                        ),
                  // TextFormField(
                  //   decoration: InputDecoration(
                  //       prefix: Icon(Icons.search),
                  //       hintText: 'I\'m at',
                  //       border: OutlineInputBorder(),
                  //       filled: true),
                  //   onChanged: (value) {
                  //     _search = value;
                  //   },
                  //   validator: (value) {
                  //     if (value.isEmpty) {
                  //       return 'Please enter a search term';
                  //     }
                  //     return null;
                  //   },
                  // ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      loading
                          ? CircularProgressIndicator()
                          : searchTextField1 = AutoCompleteTextField<Stations1>(
                              key: key1,
                              clearOnSubmit: false,
                              suggestions: stations1,
                              style: TextStyle(
                                  color: Colors.black, fontSize: 20.0),
                              decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 20.0),
                                enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.black)),
                                hintText: 'I Want to Go',
                                hintStyle: TextStyle(
                                    color: Colors.grey.withOpacity(1.0)),
                                focusColor: Colors.red,
                                focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.red[600]),
                                ),
                              ),
                              itemFilter: (item1, query1) {
                                return item1.name1
                                    .toLowerCase()
                                    .startsWith(query1.toLowerCase());
                              },
                              itemSorter: (c, d) {
                                return c.name1.compareTo(d.name1);
                              },
                              itemSubmitted: (item1) {
                                searchTextField1.textField.controller.text =
                                    item1.name1;
                                _search1 = item1.id1.toString();
                              },
                              itemBuilder: (context1, item1) {
                                return row1(item1);
                              },
                            ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: RawMaterialButton(
                      onPressed: () {
                        searchTrain(_search);
                        searchTrain(_search1);
                      },
                      fillColor: Colors.red,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Text(
                          "Search",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            _directTrains == null
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
                      children: _directTrains.map((trainsList) {
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
