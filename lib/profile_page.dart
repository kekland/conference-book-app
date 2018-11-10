import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfilePage extends StatefulWidget {
  final String username;

  const ProfilePage({Key key, this.username}) : super(key: key);
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
          title: Text('Profile',
              style: TextStyle(fontFamily: 'Futura', color: Colors.black)),
          elevation: 0.0,
          backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                child: Text(widget.username[0].toUpperCase()),
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue,
                minRadius: 64.0,
                maxRadius: 64.0,
              ),
              Text(widget.username),
            ],
          ),
        ),
      ),
    );
  }
}
