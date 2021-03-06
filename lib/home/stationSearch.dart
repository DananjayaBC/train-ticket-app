import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:train_ticket_app/models/stations.dart';
import 'package:train_ticket_app/models/stations2.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:train_ticket_app/widgets/provider_widet.dart';
import 'package:intl/intl.dart';

class StationSearch extends StatefulWidget {
  final dio =
      Dio(BaseOptions(baseUrl: 'http://api.lankagate.gov.lk:8280', headers: {
    'Accept': 'application/json',
    'Authorization': 'Bearer b1a1e3d6-70b6-35af-ae53-a6d6b3232592'
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
  String _search3;
  String _search4;

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
                                _search3 = item.name;
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
                                    _search4 = item1.name1;
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
                            .map((json) =>
                                PriceItem(PriceList(json), _search3, _search4))
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
                            .map((json) =>
                                TrainItem(TrainList(json), PriceList(json)))
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
  final PriceList priceList;

  TrainItem(this.trainList, this.priceList);

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
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue)),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                          "Arrive at ${trainList.startStationName}              ${trainList.arrivalTime}",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          )),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                          "Reach ${trainList.endStationName}                ${trainList.arrivalTimeEndStation}",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold)),
                      SizedBox(
                        height: 10,
                      ),
                      Text("Train Type     ${trainList.trainType}",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold)),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                          "End Station                ${trainList.finalStationName}",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold)),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                          "Available classes                ${trainList.classList}",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold)),
                      Text(
                          "Available classes                ${priceList.priceLKR}",
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

class PriceItem extends StatefulWidget {
  final PriceList priceList;
  final String _search3;
  final String _search4;

  PriceItem(this.priceList, this._search3, this._search4);

  @override
  _PriceItemState createState() => _PriceItemState();
}

class _PriceItemState extends State<PriceItem> {
  final db = Firestore.instance;
  Razorpay _razorpay;

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear(); // Removes all listeners
  }

  void openCheackout() async {
    var options = {
      'key': 'rzp_test_o4J55Xwza1ZYNd',
      'amount': num.parse(widget.priceList.priceLKR) *
          100, //in the smallest currency sub-unit.
      'name': 'Acme Corp.',
      'order_id': '', // Generate order_id using Orders API
      'description': '',
      'timeout': 300, // in seconds
      'prefill': {'contact': '', 'email': ''}
    };
    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint(e);
    }
  }

  String formattedDate;

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    Fluttertoast.showToast(msg: "SUCCESS " + response.paymentId);

    final uid = await Provider.of(context).auth.getCurrentUID();
    await db.collection("userData").document(uid).collection('payments').add({
      'price': widget.priceList.priceLKR,
      'class': widget.priceList.className,
      'startStation': 'Mirigama',
      'endStation': 'Gampaha',
      'name': 'Dananjaya jayalath',
      'description': '${widget._search3} - ${widget._search4}',
      'PaymentType': 'paid',
      'date': formattedDate,
      'PaymentId': response.paymentId
    });
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
        msg: "ERROR" + response.code.toString() + " - " + response.message);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(msg: "EXTERNAL WALLET" + response.walletName);
  }

  @override
  Widget build(BuildContext context) {
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd – hh:mm');
    formattedDate = formatter.format(now);
    print(formattedDate); // 2016-01-25

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '${widget.priceList.className}-',
          style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Colors.blueGrey),
        ),
        // Text(
        //   'Price Rs.${widget.priceList.priceLKR}',
        //   style: TextStyle(
        //       fontSize: 15, fontWeight: FontWeight.w500, color: Colors.black),
        // ),
        RaisedButton.icon(
          onPressed: () async {
            openCheackout();
          },
          icon: Icon(Icons.payment),
          label: Text('${widget.priceList.priceLKR}'),
          color: Colors.orangeAccent,
          textColor: Colors.white,
        ),
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
  final String trainType;
  final List classList;
  final String className;

  TrainList._({
    this.startStationName,
    this.endStationName,
    this.arrivalTimeEndStation,
    this.arrivalTime,
    this.finalStationName,
    this.trainType,
    this.classList,
    this.className,
  });

  factory TrainList(Map json) => TrainList._(
        startStationName: json['startStationName'],
        endStationName: json['endStationName'],
        arrivalTimeEndStation: json['arrivalTimeEndStation'],
        arrivalTime: json['arrivalTime'],
        finalStationName: json['finalStationName'],
        trainType: json['trainType'],
        classList: json['classList'],
      );
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
