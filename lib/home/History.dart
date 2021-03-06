import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:train_ticket_app/widgets/provider_widet.dart';

class History extends StatelessWidget {
  const History({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder(
          stream: getUsersTripsStreamSnapshots(context),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return const Text("Loading...");
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
        .collection('payments')
        .snapshots();
  }

  Widget buildTripCard(BuildContext context, DocumentSnapshot payment) {
    return new Container(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
                child: Row(children: <Widget>[
                  Text(
                    payment['description'],
                    style: new TextStyle(fontSize: 30.0),
                  ),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
                child: Row(children: <Widget>[
                  Text(
                    "Payment ID - ${(payment['PaymentId'])} ",
                    style: TextStyle(color: Colors.green, fontSize: 20.00),
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
