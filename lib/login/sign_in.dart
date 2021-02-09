// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:train_ticket_app/home/nav.dart';
// import 'package:train_ticket_app/login/create_login.dart';
// import 'file:///C:/Users/Danac/AndroidStudioProjects/train_ticket_app/lib/home/home.dart';
// import 'package:flutter/cupertino.dart';

// class SignIn extends StatefulWidget {
//   final Function aBackToHome;

//   SignIn({this.aBackToHome});

  
//   @override
//   _SignInState createState() => _SignInState();
// }

// class _SignInState extends State<SignIn> {

 
//   FirebaseAuth _auth = FirebaseAuth.instance;
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   final TextEditingController _emailController = TextEditingController();
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//   final TextEditingController _passwordController = TextEditingController();

//   bool _isChecked = false;

//   @override
//   Widget build(BuildContext context) {
//     return Form(
//         key: _scaffoldKey,
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               Column(
//                 children: [
//                   Text(
//                     'Log In',
//                     style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 24.0,
//                         fontWeight: FontWeight.w700),
//                   ),
//                 ],
//               ),
//               SizedBox(
//                 height: 20.0,
//               ),
//               TextFormField(
//                 controller: _emailController,
//                 validator: (emailValue) {
//                   if (emailValue.isEmpty) {
//                     return 'This Field is Manatory';
//                   }
//                   String p = "[a-zA-Z0-9\+\.\_\%\-\+]{1,256}" +
//                       "\\@" +
//                       "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}" +
//                       "(" +
//                       "\\." +
//                       "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}" +
//                       ")+";
//                   RegExp regExp = new RegExp(p);
//                   if (regExp.hasMatch(emailValue)) {
//                     // So, the email is valid
//                     return null;
//                   }
//                   return 'This is not a valid email';
//                 },
//                 decoration: InputDecoration(
//                   errorStyle: TextStyle(color: Colors.white),
//                   enabledBorder: UnderlineInputBorder(
//                       borderSide: BorderSide(color: Colors.white)),
//                   hintText: 'Enter Email',
//                   hintStyle: TextStyle(color: Colors.white.withOpacity(0.6)),
//                   focusColor: Colors.white,
//                   focusedBorder: UnderlineInputBorder(
//                     borderSide: BorderSide(color: Colors.white),
//                   ),
//                 ),
//                 style: TextStyle(color: Colors.white, fontSize: 22.0),
//               ),
//               SizedBox(
//                 height: 20.0,
//               ),
//               TextFormField(
//                 controller: _passwordController,
//                 validator: (String value) {
//                   if (value.isEmpty) {
//                     return 'Please enter your password';
// //                   }
//                   return null;
//                 },
//                 obscureText: true,
//                 decoration: InputDecoration(
//                   errorStyle: TextStyle(color: Colors.white),
//                   enabledBorder: UnderlineInputBorder(
//                       borderSide: BorderSide(color: Colors.white)),
//                   hintText: 'Password',
//                   hintStyle: TextStyle(color: Colors.white.withOpacity(0.6)),
//                   focusColor: Colors.white,
//                   focusedBorder: UnderlineInputBorder(
//                     borderSide: BorderSide(color: Colors.white),
//                   ),
//                 ),
//                 style: TextStyle(color: Colors.white, fontSize: 22.0),
//               ),
//               SizedBox(
//                 height: 10.0,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Checkbox(
//                       activeColor: Colors.orange,
//                       value: _isChecked,
//                       onChanged: (newValue) {
//                         setState(() {
//                           _isChecked = newValue;
//                         });
//                       }),
//                   SizedBox(
//                     height: 20.0,
//                   ),
//                   Text(
//                     'Remember Password',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 16.0,
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(
//                     height: 05.0,
//                   ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                  InkWell(
//                   onTap: () {
//                      widget.aBackToHome();
//                   },
//                   child: Text(
//                     'CANCEL',
//                     style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 20.0,
//                         fontWeight: FontWeight.bold),
//                   ),
//                 ),
//                   SizedBox(
//                   width: 38.0,
//                 ),
              //     InkWell(
              //     onTap: () {
              //       if (_formKey.currentState.validate()) {
              //         _signInWithEmailAndPassword();
              //       }
              //     },
              //        child: Container(
              //       padding:
              //           EdgeInsets.symmetric(vertical: 16.0, horizontal: 34.0),
              //       decoration: BoxDecoration(
              //           color: Colors.white,
              //           borderRadius: BorderRadius.circular(30.0)),
                 
              //       child: Text(
              //         'LOG IN',
              //         style: TextStyle(
              //             color: Colors.red,
              //             fontSize: 20.0,
              //             fontWeight: FontWeight.bold),
              //         textAlign: TextAlign.center,
              //       ),
              //        ),
              //     ),
                
              // ],
              // ),
//               SizedBox(
//                 height: 20.0,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Container(
//                       padding: EdgeInsets.all(20.0),
//                       decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(30.0)),
//                       child:
//                           Icon(FontAwesomeIcons.facebookF, color: Colors.red)),
//                   SizedBox(
//                     width: 38.0,
//                   ),
//                   Container(
//                       padding: EdgeInsets.all(20.0),
//                       decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(30.0)),
//                       child: Icon(FontAwesomeIcons.twitter, color: Colors.red)),
//                 ],
//               ),
//               SizedBox(
//                 height: 20.0,
//               ),
//               Text(
//                 'FOGOT PASSWORD?',
//                 style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 16.0,
//                     fontWeight: FontWeight.bold,
//                     decoration: TextDecoration.underline),
//               ),
             
            
//             ],
//           ),
//         ));
//   }

//   @override
//   void dispose() {
//     _emailController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }

//   void _signInWithEmailAndPassword() async {
//     try {
//       final User user = (await _auth.signInWithEmailAndPassword(
//         email: _emailController.text,
//         password: _passwordController.text,
//       ))
//           .user;
//       if (!user.emailVerified) {
//         await user.sendEmailVerification();
//       }
      
//       Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) {
//         return  Home(
//           user: user,
//         );
        
//       })
//       );
//     } catch (err) {
//       print(err.code);
//       if (err.code == 'wrong-password') {
//         var alertDialog = AlertDialog(
//           titleTextStyle: TextStyle(
//             color: Colors.red,
//             fontSize: 28.0,
//             fontWeight: FontWeight.bold,
//           ),
//           title: Text('The Password was incorrect, please try again'),
//           content: Text('Enter Another Email'),
//         );

//         showDialog(
//             context: context,
//             builder: (BuildContext context) {
//               return alertDialog;
//             });
//       }
//     }
   

//     void _signOut() async {
//       await _auth.signOut();
//     }
//   }
// }
