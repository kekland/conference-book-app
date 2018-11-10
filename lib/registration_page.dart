import 'package:conference/application.dart';
import 'package:conference/circular_reveal_widget.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rect_getter/rect_getter.dart';

class RegistrationPage extends StatefulWidget {
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  var loginKey = RectGetter.createGlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Theme(
        data: ThemeData(
          primaryColor: Colors.white,
          accentColor: Colors.white,
          cursorColor: Colors.white,
          brightness: Brightness.dark,
          inputDecorationTheme: InputDecorationTheme(
            labelStyle: TextStyle(color: Colors.white),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(16.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 2.0),
              borderRadius: BorderRadius.circular(16.0),
            )
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.blue,
                Colors.lightBlue,
              ],
            ),
          ),
          padding: const EdgeInsets.all(32.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text('Registration',
                      style: TextStyle(
                          fontFamily: 'Futura',
                          fontSize: 48.0,
                          color: Colors.white,
                          fontWeight: FontWeight.w500)),
                  SizedBox(height: 8.0),
                  TextField(
                    decoration: InputDecoration(
                      prefixIcon:
                          Icon(FontAwesomeIcons.solidEnvelope, size: 18.0),
                      labelText: 'E-Mail',
                    ),
                  ),
                  SizedBox(height: 8.0),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Username',
                      prefixIcon: Icon(FontAwesomeIcons.userAlt, size: 18.0),
                    ),
                  ),
                  SizedBox(height: 8.0),
                  TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(FontAwesomeIcons.lock, size: 18.0),
                      labelText: 'Password',
                    ),
                  ),
                  SizedBox(height: 8.0),
                  TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(FontAwesomeIcons.lock, size: 18.0),
                      labelText: 'Repeat your password',
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Row(
                    children: [
                      RectGetter(
                        key: loginKey,
                        child: FlatButton.icon(
                          icon: Icon(FontAwesomeIcons.signInAlt, size: 18.0),
                          label: Text('I have an account'),
                          onPressed: () {
                            Application.router.navigateTo(
                              context,
                              "/login",
                              transition: TransitionType.custom,
                              transitionDuration: Duration(milliseconds: 400),
                              transitionBuilder:
                                  (context, animation, _, widget) {
                                return PageRevealWidget(
                                  child: widget,
                                  revealPercent: animation.value,
                                  clickPosition:
                                      RectGetter.getRectFromKey(loginKey)
                                          .center,
                                );
                              },
                            );
                          },
                          textColor: Colors.white,
                        ),
                      ),
                      FlatButton.icon(
                        icon: Icon(FontAwesomeIcons.chevronRight, size: 18.0),
                        label: Text('Register'),
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
