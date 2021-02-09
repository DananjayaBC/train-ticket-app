import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:train_ticket_app/login/home_signin_widget.dart';
import 'package:train_ticket_app/login/create_login.dart';
import 'package:train_ticket_app/login/sign_in.dart';

class MenuFrame extends StatelessWidget {
  PageController pageController = PageController();
  Duration _animationDuration = Duration(milliseconds: 1);

  void _changePage(int page) {
    pageController.animateToPage(page,
        duration: _animationDuration, curve: Curves.easeIn);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 28.0, vertical: 60.0),
            child: Column(
              children: <Widget>[
                Icon(
                  FontAwesomeIcons.train,
                  color: Color.fromRGBO(245, 48, 111, 1.0),
                  size: 60.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'TRAIN',
                      style: TextStyle(
                        fontSize: 38.0,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(245, 48, 111, 1.0),
                      ),
                    ),
                    Text(
                      'TICKET',
                      style: TextStyle(
                        fontSize: 38.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                Text(
                  'Buy Train Ticket',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 55.0,
                ),
                Expanded(
                  child: PageView(
                     physics: NeverScrollableScrollPhysics(),
                    controller: pageController,
                    children: [
                      HomeSigninWidget(
                        goToPageCallback: (page) {
                          _changePage(page);
                        },
                      ),
                      //    SignIn(
                      //   aBackToHome: () {
                      //     _changePage(0);
                         
                      //   },
                      // ),
                      // SignUpView(
                      //   cancelBackToHome: () {
                      //     _changePage(0);
                      //   },
                      // ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromRGBO(106, 90, 205, 1.0),
              Color.fromRGBO(245, 50, 111, 1.0),
            ],
          ),
        ),
      ),
    );
  }
}
