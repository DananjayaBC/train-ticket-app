import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:train_ticket_app/models/stations.dart';
import 'package:train_ticket_app/models/stations2.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class StationSearch extends StatefulWidget {
  final dio =
      Dio(BaseOptions(baseUrl: 'http://api.lankagate.gov.lk:8280', headers: {
    'Accept': 'application/json',
    'Authorization': 'Bearer 92c36daa-65d9-3281-b5c4-d57d36a3e82f'
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
            // Text(
            //   stations.id.toString(),
            //   style: TextStyle(
            //     fontSize: 16.0,
            //     color: Colors.black,
            //   ),
            // ),
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
          ],
        ),
      ),
    );
  }

  final _formKey = GlobalKey<FormState>();

  var _autoValidate = false;
  var _search;
  var _search1;
  List _directTrains;
  List _priceTrains;
  DateTime date = DateTime.now();

  TimeOfDay time = TimeOfDay.now();

  Future<Null> selectTime(BuildContext context) async {
    final TimeOfDay picked =
        await showTimePicker(context: context, initialTime: time);

    if (picked != null) {
      setState(() {
        time = picked;
      });
    }
  }

//Date Picker
  Future<Null> selectTimePicker(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: date,
        firstDate: DateTime(2020),
        lastDate: DateTime(2022));

    if (picked != null && picked != date) {
      setState(() {
        date = picked;
      });
    }
  }

  void searchTrain(String query) async {
    final response = await widget.dio.get(
      "/railway/1.0/train/searchTrain?startStationID=$_search&endStationID=$_search1&startTime=${time.hour}:${time.minute}:00&endTime=23:59:00&lang=en&searchDate=$date",
    );
    setState(() {
      _directTrains = response.data['RESULTS']['directTrains']['trainsList'];
    });
  }

  void priceTrain(String query) async {
    final response = await widget.dio.get(
      "/railway/1.0/ticket/getPrice?startStationID=$_search&endStationID=$_search1&lang=en",
    );
    setState(() {
      _priceTrains = response.data['RESULTS']['priceList'];
    });
  }

  @override
  Widget build(BuildContext context) {
    var myController = TextEditingController();
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      // appBar: AppBar(
      //   title: Center(child: Text("Train Search")),
      //   backgroundColor: Colors.blue,
      // ),
      body: Container(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(32),
                child: Form(
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
                              decoration: new InputDecoration(
                                labelText: "I\'m At",
                                fillColor: Colors.white,
                                border: new OutlineInputBorder(
                                  borderRadius: new BorderRadius.circular(25.0),
                                  borderSide: new BorderSide(),
                                ),
                                //fillColor: Colors.green
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
                        height: 10.0,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          loading
                              ? CircularProgressIndicator()
                              : searchTextField1 =
                                  AutoCompleteTextField<Stations1>(
                                  key: key1,
                                  clearOnSubmit: false,
                                  suggestions: stations1,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 20.0),
                                  decoration: new InputDecoration(
                                    labelText: "I Want to Go",
                                    fillColor: Colors.white,
                                    border: new OutlineInputBorder(
                                      borderRadius:
                                          new BorderRadius.circular(25.0),
                                      borderSide: new BorderSide(),
                                    ),
                                    //fillColor: Colors.green
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
                      Row(
                        children: [
                          FlatButton.icon(
                            onPressed: () {
                              selectTimePicker(context);
                            },
                            icon: Icon(Icons.calendar_today),
                            label: Text('Setelct Date'),
                            color: Colors.blue,
                            textColor: Colors.white,
                          ),

                          SizedBox(
                            width: 80,
                          ),
                          // Text(date.toString()),
                          FlatButton.icon(
                            onPressed: () {
                              selectTime(context);
                            },
                            icon: Icon(Icons.timer),
                            label: Text('Setelct Time'),
                            color: Colors.green,
                            textColor: Colors.white,
                          ),
                          //Text(time.toString())
                        ],
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: RawMaterialButton(
                          onPressed: () {
                            searchTrain(_search);
                            searchTrain(_search1);
                            priceTrain(_search);
                            priceTrain(_search1);
                            date;
                            time;
                          },
                          fillColor: Colors.red,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Text(
                              "Search",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              _priceTrains == null
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
                          'Search Trains',
                          style: TextStyle(
                              color: Colors.black12,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ))
                  : Container(
                      child: Column(
                        children: _priceTrains
                            .map((json) => PriceItem(PriceList(json)))
                            .toList(),
                      ),
                    ),
              _directTrains == null
                  ? Expanded(
                      child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(
                          backgroundColor: Colors.black12,
                        )
                      ],
                    ))
                  : Expanded(
                      child: ListView(
                        children: _directTrains
                            .map((json) => TrainItem(TrainList(json)))
                            .toList(),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

class TrainItem extends StatelessWidget {
  final TrainList trainList;

  TrainItem(this.trainList);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        return showDialog(
          context: context,
          builder: (context) {
            return Center(
                child: Material(
              type: MaterialType.transparency,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                padding: EdgeInsets.all(14),
                width: MediaQuery.of(context).size.width * 0.7,
                height: 320,
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                          "${trainList.startStationName}-${trainList.endStationName}",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
            ));
          },
        );
      },
      child: Card(
        child: Row(children: [
          Container(
            height: 100,
            width: 100,
            color: Colors.blueGrey,
            child: Icon(
              Icons.train_rounded,
              size: 30,
              color: Colors.white,
            ),
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      "${trainList.startStationName}-${trainList.endStationName}",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                  Text(
                    "To-${trainList.finalStationName}",
                    style: TextStyle(fontSize: 14, color: Colors.redAccent),
                  ),
                  Text(
                    "Arrival Time-${trainList.arrivalTime}",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  Text("End Time-${trainList.arrivalTimeEndStation}",
                      style: TextStyle(fontWeight: FontWeight.w500)),
                ],
              ),
            ),
          )
        ]),
      ),
    );
    // return ListTile(
    //   title: Text(trainList.startStationName),
    //   subtitle: Text(trainList.endStationName),
    //   trailing: Text('Arivel Time-${trainList.arrivalTimeEndStation}'),
    // );
  }
}

class PriceItem extends StatelessWidget {
  final PriceList priceList;

  PriceItem(this.priceList);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '${priceList.className}-',
          style: TextStyle(
              fontSize: 15, fontWeight: FontWeight.w500, color: Colors.green),
        ),
        Text(
          'Price Rs.${priceList.priceLKR}',
          style: TextStyle(
              fontSize: 15, fontWeight: FontWeight.w500, color: Colors.black),
        )
      ],

      // trailing: Text('Arivel Time-${trainList.arrivalTimeEndStation}'),
    );
    // return ListTile(
    //   title: Text(priceList.priceLKR),
    //   subtitle: Text(priceList.className),
    // );
  }
}

class TrainList {
  final String startStationName;
  final String endStationName;
  final String arrivalTimeEndStation;
  final String arrivalTime;
  final String finalStationName;

  TrainList._({
    this.startStationName,
    this.endStationName,
    this.arrivalTimeEndStation,
    this.arrivalTime,
    this.finalStationName,
  });

  factory TrainList(Map json) => TrainList._(
      startStationName: json['startStationName'],
      endStationName: json['endStationName'],
      arrivalTimeEndStation: json['arrivalTimeEndStation'],
      arrivalTime: json['arrivalTime'],
      finalStationName: json['finalStationName']);
}

class PriceList {
  final String className;
  final String priceLKR;

  PriceList._({
    this.className,
    this.priceLKR,
  });
  factory PriceList(Map json) =>
      PriceList._(className: json['className'], priceLKR: json['priceLKR']);
}
