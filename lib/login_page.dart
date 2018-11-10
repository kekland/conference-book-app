import 'package:conference/application.dart';
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            children: [
              Text('Title',
                  style: TextStyle(
                      fontFamily: 'Futura',
                      fontSize: 48.0,
                      fontWeight: FontWeight.w500)),
              SizedBox(height: 8.0),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Username',
                  prefixIcon: Icon(FontAwesomeIcons.userAlt, size: 18.0),
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
                          return Transform(
                            transform: new Matrix4.translationValues(0.0, 20.0 * (1.0 - animation.value), 0.0),
                            child: Opacity(
                              opacity: animation.value,
                              child: widget,
                            ),
                          );
                        },
                      );
                    },
                    textColor: Theme.of(context).primaryColor,
                  ),
                  FlatButton.icon(
                    icon: Icon(FontAwesomeIcons.chevronRight, size: 18.0),
                    label: Text('Sign in'),
                    onPressed: () {},
                    textColor: Theme.of(context).accentColor,
                  )
                ],
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
              ),
            ],
            mainAxisSize: MainAxisSize.min,
          ),
        ),
      ),
    );
  }
}
