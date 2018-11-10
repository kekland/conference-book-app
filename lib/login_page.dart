import 'package:conference/application.dart';
import 'package:conference/circular_reveal_widget.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginPage extends StatefulWidget {
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Theme(
        data: ThemeData(
          primaryColor: Colors.white,
          accentColor: Colors.white,
          brightness: Brightness.dark,
          inputDecorationTheme: InputDecorationTheme(
            labelStyle: TextStyle(color: Colors.white),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(8.0),
            ),            
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.green,
                Colors.lime,
              ],
            ),
          ),
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text('Login',
                      style: TextStyle(
                          fontFamily: 'Futura',
                          fontSize: 48.0,
                          color: Colors.white,
                          fontWeight: FontWeight.w500)),
                  SizedBox(height: 8.0),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Username',
                      prefixIcon: Icon(FontAwesomeIcons.userCog, size: 18.0),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0)),
                    ),
                  ),
                  SizedBox(height: 8.0),
                  TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(FontAwesomeIcons.lock, size: 18.0),
                      labelText: 'Password',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0)),
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Row(
                    children: [
                      FlatButton.icon(
                        icon: Icon(FontAwesomeIcons.signInAlt, size: 18.0),
                        label: Text('Sign up'),
                        onPressed: () {
                          Application.router.navigateTo(
                            context,
                            "/register",
                            transition: TransitionType.custom,
                            transitionDuration: Duration(milliseconds: 250),
                            transitionBuilder: (context, animation, _, widget) {
                              return PageRevealWidget(
                                  child: widget,
                                  revealPercent: animation.value,
                                  );
                            },
                          );
                        },
                        textColor: Colors.white,
                      ),
                      FlatButton.icon(
                        icon: Icon(FontAwesomeIcons.chevronRight, size: 18.0),
                        label: Text('Sign in'),
                        onPressed: () {},
                        textColor: Colors.white,
                      ),
                    ],
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  ),
                ],
                mainAxisSize: MainAxisSize.min,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
