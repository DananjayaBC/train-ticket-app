import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:train_ticket_app/models/stations.dart';
import 'package:train_ticket_app/models/stations2.dart';

import 'dart:convert';

class History extends StatefulWidget {
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  AutoCompleteTextField searchTextField;
  AutoCompleteTextField searchTextField1;
  GlobalKey<AutoCompleteTextFieldState<Stations>> key = new GlobalKey();
  GlobalKey<AutoCompleteTextFieldState<Stations1>> key1 = new GlobalKey();

  static List<Stations> stations = new List<Stations>();
  static List<Stations1> stations1 = new List<Stations1>();
  bool loading = true;
  String _search;

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

  @override
  Widget build(BuildContext context) {
    var myController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(245, 50, 111, 1.0),
        title: Center(
          child: Text("Buy Tickets"),
        ),
      ),
      body: Container(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
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
                          searchTextField.textField.controller.text = item.name;
                          _search = item.id.toString();
                        },
                        itemBuilder: (context, item) {
                          return row(item);
                        },
                        
                        controller: myController,
                      ),
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
                            style:
                                TextStyle(color: Colors.black, fontSize: 20.0),
                            decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 20.0),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black)),
                              hintText: 'I Want to Go',
                              hintStyle: TextStyle(
                                  color: Colors.grey.withOpacity(1.0)),
                              focusColor: Colors.red,
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.red[600]),
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
                              setState(() {
                                searchTextField1.textField.controller.text =
                                    item1.name1;
                              });
                            },
                            itemBuilder: (context1, item1) {
                              return row1(item1);
                            },
                          ),
                  ],
                ),
                SizedBox(
                  height: 30.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // InkWell(
                    //   onTap: () {},
                    //   child: Text(
                    //     'SEARCH',
                    //     style: TextStyle(
                    //         color: Colors.red,
                    //         fontSize: 20.0,
                    //         fontWeight: FontWeight.bold),
                    //   ),
                    // ),
                    // SizedBox(
                    //   width: 38.0,
                    // ),
                    InkWell(
                      onTap: () async {},
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 16.0, horizontal: 34.0),
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(245, 50, 111, 1.0),
                            borderRadius: BorderRadius.circular(30.0)),
                        child: Text(
                          'SEARCH',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        // When the user presses the button, show an alert dialog containing
        // the text that the user has entered into the text field.
        onPressed: () {
          return showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                // Retrieve the text the that user has entered by using the
                // TextEditingController.
                content: Text(
                  myController.toString(),
                ),
              );
            },
          );
        },
        tooltip: 'Show me the value!',
        child: Icon(Icons.text_fields),
      ),
    );
  }
}
