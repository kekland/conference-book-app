import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RegistrationPage extends StatefulWidget {
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text('Registration',
                    style: TextStyle(
                        fontFamily: 'Futura',
                        fontSize: 48.0,
                        fontWeight: FontWeight.w500)),
                SizedBox(height: 8.0),
                TextField(
                  decoration: InputDecoration(
                    prefixIcon:
                        Icon(FontAwesomeIcons.solidEnvelope, size: 18.0),
                    labelText: 'E-Mail',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0)),
                  ),
                ),
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
                TextField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(FontAwesomeIcons.userAlt, size: 18.0),
                    labelText: 'Your name',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0)),
                  ),
                ),
                SizedBox(height: 8.0),
                TextField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(FontAwesomeIcons.solidBuilding, size: 18.0),
                    labelText: 'Company (not required)',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0)),
                  ),
                ),
                SizedBox(height: 8.0),
                Row(
                  children: [
                    FlatButton.icon(
                      icon: Icon(FontAwesomeIcons.signInAlt, size: 18.0),
                      label: Text('I have an account'),
                      onPressed: () {},
                      textColor: Theme.of(context).primaryColor,
                    ),
                    FlatButton.icon(
                      icon: Icon(FontAwesomeIcons.chevronRight, size: 18.0),
                      label: Text('Register'),
                      onPressed: () {},
                      textColor: Theme.of(context).accentColor,
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
    );
  }
}
