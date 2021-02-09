import 'package:flutter/material.dart';
import 'package:train_ticket_app/home/nav.dart';
import 'package:train_ticket_app/login/create_login.dart';
import 'package:train_ticket_app/login/first_view.dart';
import 'package:train_ticket_app/services/auth_service.dart';
import 'package:train_ticket_app/widgets/provider_widet.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      auth: AuthService(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Train app",
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: HomeController(),
        routes: <String, WidgetBuilder>{
          '/nav': (BuildContext context) => Nav(),
          '/firstView': (BuildContext context) => FirstView(),
          '/signUp': (BuildContext context) =>
              SignUpView(authFormType: AuthFormType.signUp),
          '/signIn': (BuildContext context) =>
              SignUpView(authFormType: AuthFormType.signIn),
          '/home': (BuildContext context) => HomeController(),
        },
      ),
    );
  }
}

class HomeController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthService auth = Provider.of(context).auth;
    return StreamBuilder<String>(
      stream: auth.onAuthStateChanged,
      builder: (context, AsyncSnapshot<String> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final bool signedIn = snapshot.hasData;
          return signedIn ? Nav() : FirstView();
        }
        return CircularProgressIndicator();
      },
    );
  }
}
// void main() async {
//   //WidgetsFlutterBinding.ensureInitialized();
//   // await Firebase.initializeApp();
//
//   runApp(MaterialApp(
//     debugShowCheckedModeBanner: false,
//     home: HomeController(),
//     routes: <String, WidgetBuilder>{
//       '/signUp': (BuildContext context) =>
//           SignUpView(authFormType: AuthFormType.signUp),
//       '/signIn': (BuildContext context) =>
//           SignUpView(authFormType: AuthFormType.signIn),
//       '/home': (BuildContext context) => HomeController(),
//     },
//     title: 'Train app',
//     theme: ThemeData(
//       primaryColor: Colors.white,
//       primarySwatch: Colors.blue,
//       visualDensity: VisualDensity.adaptivePlatformDensity,
//     ),
//   ));
// }
//
// class HomeController extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final AuthService auth = Provider.of(context).auth;
//     return StreamBuilder<String>(
//       stream: auth.onAuthStateChanged,
//       builder: (context, AsyncSnapshot<String> snapshot) {
//         if (snapshot.connectionState == ConnectionState.active) {
//           final bool signedIn = snapshot.hasData;
//           return signedIn ? Home() : Home();
//         }
//         return CircularProgressIndicator();
//       },
//     );
//   }
// }

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   WidgetsFlutterBinding.ensureInitialized();
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   String email = prefs.getString("email");
//   runApp(MaterialApp(
//     debugShowCheckedModeBanner: false,
//     home: email == null ? Login() : Home(),
//     title: 'Train app',
//     theme: ThemeData(
//       primaryColor: Colors.white,
//       primarySwatch: Colors.blue,
//       visualDensity: VisualDensity.adaptivePlatformDensity,
//     ),
//   ));
// }
