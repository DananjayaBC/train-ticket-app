import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:train_ticket_app/widgets/provider_widet.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:intl/intl.dart';

class History extends StatelessWidget {
  String formattedDate;
  History({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    formattedDate = formatter.format(now);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(245, 48, 111, 1.0),
        title: Center(
            child: Text(
          'Tickets',
          style: TextStyle(
            color: Colors.white,
          ),
        )),
      ),
      body: StreamBuilder(
          stream: getUsersTripsStreamSnapshots(context),
          builder: (context, snapshot) {
            if (!snapshot.hasData)
              return Container(
                padding: EdgeInsets.all(152),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.qr_code_scanner_outlined,
                      color: Colors.black,
                      size: 110,
                    ),
                    Text(
                      'No Tickets',
                      style: TextStyle(
                          color: Colors.black38,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              );
            ;
            return new ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (BuildContext context, int index) =>
                    buildTripCard(context, snapshot.data.documents[index]));
          }),
    );
  }

  Stream<QuerySnapshot> getUsersTripsStreamSnapshots(
      BuildContext context) async* {
    final uid = await Provider.of(context).auth.getCurrentUID();
    yield* Firestore.instance
        .collection('userData')
        .document(uid)
        .collection(formattedDate)
        .orderBy('date', descending: true)
        .snapshots();
  }

  Widget buildTripCard(BuildContext context, DocumentSnapshot payment) {
    return new GestureDetector(
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BarcodeWidget(
                        barcode: Barcode.qrCode(),
                        color: Colors.black,
                        data: "Start Staion - ${payment['startStation']}\n"
                            "End Station - ${(payment['endStation'])}\n"
                            "Price - ${(payment['price'])}\n"
                            "Class - ${(payment['class'])}\n"
                            "Payment - ${(payment['PaymentType'])}\n"
                            "Date - ${(payment['date'])}\n",
                        width: 200,
                        height: 200,
                      ),
                    ],
                  ),
                ),
              ),
            ));
          },
        );
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
                  child: Row(children: <Widget>[
                    Text(
                      payment['description'],
                      style: new TextStyle(fontSize: 25.0),
                    ),
                  ]),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
                  child: Row(children: <Widget>[
                    Text(
                      "${(payment['date'])} ",
                      style: TextStyle(color: Colors.red),
                    ),
                  ]),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
                  child: Row(children: <Widget>[
                    Text(
                      "Class - ${(payment['class'])} ",
                      style: TextStyle(color: Colors.blue, fontSize: 20.00),
                    ),
                  ]),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                  child: Row(
                    children: <Widget>[
                      Text(
                        "\Rs.${(payment['price'] == null) ? "n/a" : payment['price']}",
                        style: new TextStyle(fontSize: 35.0),
                      ),
                      Spacer(),
                      Icon(Icons.train_rounded),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
