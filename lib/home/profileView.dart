import 'package:flutter/material.dart';

import 'package:train_ticket_app/login/first_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:train_ticket_app/widgets/provider_widet.dart';

class ProfileView extends StatefulWidget {
  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(
              FontAwesomeIcons.user,
              color: Color.fromRGBO(245, 48, 111, 1.0),
              size: 60.0,
            ),
            SizedBox(height: 30),
            FutureBuilder(
              future: Provider.of(context).auth.getCurrentUser(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return displayUserInformation(context, snapshot);
                } else {
                  return CircularProgressIndicator();
                }
              },
            )
          ],
        ),
      ),
    );
  }

  Widget displayUserInformation(context, snapshot) {
    final user = snapshot.data;

    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            " ${user.displayName ?? 'Anonymous'}",
            style: TextStyle(
                color: Colors.black, fontSize: 28.0, fontFamily: "Nexa"),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "${user.email ?? 'Anonymous'}",
            style: TextStyle(
                color: Color(0xFFFE1483),
                fontSize: 22.0,
                fontFamily: "NexaLight"),
          ),
        ),
        SizedBox(
          height: 35,
        ),
        showSignOut(context, user.isAnonymous),
      ],
    );
  }

  Widget showSignOut(context, bool isAnonymous) {
    if (isAnonymous == true) {
      return RaisedButton(
        child: Text("Sign In To Save Your Data"),
        onPressed: () {
          Navigator.of(context).pushNamed('/convertUser');
        },
      );
    } else {
      return FlatButton.icon(
        icon: Icon(Icons.logout),
        label: Text('Sign Out'),
        color: Colors.red,
        textColor: Colors.white,
        onPressed: () async {
          try {
            await Provider.of(context).auth.signOut();
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => FirstView()));
          } catch (e) {
            print(e);
          }
        },
      );
    }
  }
}
