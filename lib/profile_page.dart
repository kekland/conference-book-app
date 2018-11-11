import 'package:conference/api.dart';
import 'package:conference/conference_room_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfilePage extends StatefulWidget {
  final String username;

  const ProfilePage({Key key, this.username}) : super(key: key);
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  List data = null;

  @override
  initState() {
    super.initState();
    _getData();
  }

  _getData() async {
    data = null;
    setState(() {});
    try {
      data = await API.getProfile(widget.username);
      if (mounted) setState(() {});
    } catch (e) {
      if (mounted)
        scaffoldKey.currentState
            .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  _getBody() {
    if (data == null) {
      return Center(
        child: SpinKitChasingDots(color: Colors.blue),
      );
    } else {
      return ListView.builder(
        itemBuilder: (context, i) {
          if (i == 0) {
            return CircleAvatar(
              child: Text(widget.username[0].toUpperCase()),
              foregroundColor: Colors.white,
              backgroundColor: Colors.blue,
              minRadius: 64.0,
              maxRadius: 64.0,
            );
          } else if (i == 1) {
            return Text(
              widget.username,
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.w500,
              ),
            );
          }
          int index = i - 2;
          return ConferenceRoomCard(
            imageURL: null,
            imageFile: null,
            capacity: data[index]['capacity'],
            closesAt: data[index]['closesAt'] != null
                ? data[index]['closesAt']
                : '17:00',
            cost: data[index]['cost'],
            location: data[index]['location'],
            name: data[index]['name'],
            opensAt: data[index]['opensAt'] != null
                ? data[index]['opensAt']
                : '8:00',
            room: data[index]['room'],
            username: data[index]['createdBy'],
            tags: [],
          );
        },
        itemCount: data.length + 2,
        padding: const EdgeInsets.all(16.0),
        physics: BouncingScrollPhysics(),
      );
    }
  }

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
      body: _getBody(),
    );
  }
}
