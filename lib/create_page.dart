import 'dart:io';

import 'package:conference/api.dart';
import 'package:conference/app_bar.dart';
import 'package:conference/application.dart';
import 'package:conference/conference_room_card.dart';
import 'package:conference/time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class CreateConferencePage extends StatefulWidget {
  @override
  _CreateConferencePageState createState() => _CreateConferencePageState();
}

class _CreateConferencePageState extends State<CreateConferencePage> {
  GlobalKey<DataCardState> dataCardKey = new GlobalKey();
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey();
  FirebaseStorage storage = FirebaseStorage.instance;
  OverlayEntry loadingOverlay;
  saveToAPI() async {
    try {
      loadingOverlay = OverlayEntry(
        builder: (context) {
          return Container(
            child: Center(
              child: SpinKitChasingDots(color: Colors.white),
            ),
            color: Colors.black38,
          );
        },
      );
      Overlay.of(context).insert(loadingOverlay);
      File imageFile;
      String name, location, capacity, cost;
      TimeOfDay opensAt, closesAt;
      List<String> tags;
      String room;
      if(dataCardKey.currentState.image == null) {
        throw 'You have to specify image';
      }
      imageFile = dataCardKey.currentState.image;
      if(dataCardKey.currentState.name == null) {
        throw 'You have to specify name';
      }
      name = dataCardKey.currentState.name;
      if(dataCardKey.currentState.location == null) {
        throw 'You have to specify location';
      }
      location = dataCardKey.currentState.location;
      if(dataCardKey.currentState.capacity == null) {
        throw 'You have to specify name';
      }
      capacity = dataCardKey.currentState.capacity;
      if(dataCardKey.currentState.cost == null) {
        throw 'You have to specify cost';
      }
      cost = dataCardKey.currentState.cost;
      if(dataCardKey.currentState.room == null) {
        throw 'You have to specify room';
      }
      cost = dataCardKey.currentState.room;
      opensAt = dataCardKey.currentState.openTime;
      closesAt = dataCardKey.currentState.closeTime;
      tags = [];

      var snapshot = await storage.ref().putFile(imageFile).onComplete;
      var url = await snapshot.ref.getDownloadURL();
      await API.createConference({
        "image": url,
        "location": location,
        "name": name,
        "cost": cost,
        "capacity": capacity,
        "room": room,
        "opens": opensAt.format(context),
        "closes": closesAt.format(context),
        "tags": tags
      });
      loadingOverlay.remove();
      Application.router.pop(context);
    }
    catch(e) {
      loadingOverlay.remove();
      String message = e.toString();
      scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text(message),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('Share your conference room',
            style: TextStyle(fontFamily: 'Futura', color: Colors.black)),
        elevation: 0.0,
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(FontAwesomeIcons.check, size: 18.0),
            onPressed: saveToAPI,
            color: Colors.blue,
          ),
        ]
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              ConferenceRoomCard(
                imageFile: (dataCardKey.currentState != null &&
                        dataCardKey.currentState.image != null)
                    ? dataCardKey.currentState.image
                    : null,
                imageURL: null,
                name: (dataCardKey.currentState != null &&
                        dataCardKey.currentState.name != null)
                    ? dataCardKey.currentState.name
                    : "Empty",
                cost: (dataCardKey.currentState != null &&
                        dataCardKey.currentState.cost != null)
                    ? dataCardKey.currentState.cost
                    : "0",
                location: (dataCardKey.currentState != null &&
                        dataCardKey.currentState.location != null)
                    ? dataCardKey.currentState.location
                    : "Empty",
                capacity: (dataCardKey.currentState != null &&
                        dataCardKey.currentState.capacity != null)
                    ? dataCardKey.currentState.capacity
                    : "Empty",
                room: (dataCardKey.currentState != null &&
                        dataCardKey.currentState.room != null)
                    ? dataCardKey.currentState.room
                    : "Empty",
                opensAt: (dataCardKey.currentState != null &&
                        dataCardKey.currentState.openTime != null)
                    ? dataCardKey.currentState.openTime
                    : TimeOfDay(hour: 8, minute: 0),
                closesAt: (dataCardKey.currentState != null &&
                        dataCardKey.currentState.closeTime != null)
                    ? dataCardKey.currentState.closeTime
                    : TimeOfDay(hour: 17, minute: 0),
                tags: (dataCardKey.currentState != null &&
                        dataCardKey.currentState.tags != null)
                    ? dataCardKey.currentState.tags
                    : [],
              ),
              DataCard(
                key: dataCardKey,
                onUpdate: () => setState(() {}),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DataCard extends StatefulWidget {
  final Function onUpdate;
  const DataCard({Key key, this.onUpdate}) : super(key: key);
  @override
  DataCardState createState() {
    return new DataCardState();
  }
}

class DataCardState extends State<DataCard> {
  String name, location, cost, capacity, room;
  TimeOfDay openTime = TimeOfDay(hour: 9, minute: 0),
      closeTime = TimeOfDay(hour: 17, minute: 0);
  List<String> tags = [];
  File image;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 2.0,
            offset: Offset(0.0, 2.0),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16.0),
      child: Theme(
        data: ThemeData(
          inputDecorationTheme: InputDecorationTheme(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.0),
              borderSide: BorderSide(color: Colors.black38, width: 1.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.0),
              borderSide: BorderSide(color: Colors.blue, width: 2.0),
            ),
          ),
        ),
        child: Column(
          children: [
            TextField(
              onChanged: (text) {
                name = text;
                widget.onUpdate();
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Name',
                prefixIcon: Icon(FontAwesomeIcons.fileSignature, size: 18.0),
              ),
            ),
            SizedBox(height: 8.0),
            TextField(
              onChanged: (text) {
                location = text;
                widget.onUpdate();
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Location',
                prefixIcon: Icon(FontAwesomeIcons.locationArrow, size: 18.0),
              ),
            ),
            SizedBox(height: 8.0),
            TextField(
              onChanged: (text) {
                cost = text;
                widget.onUpdate();
              },
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Cost per hour',
                prefixIcon: Icon(FontAwesomeIcons.dollarSign, size: 18.0),
              ),
            ),
            SizedBox(height: 8.0),
            TextField(
              onChanged: (text) {
                capacity = text;
                widget.onUpdate();
              },
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Capacity',
                prefixIcon: Icon(FontAwesomeIcons.chair, size: 18.0),
              ),
            ),
            SizedBox(height: 8.0),
            TextField(
              onChanged: (text) {
                room = text;
                widget.onUpdate();
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Room',
                prefixIcon: Icon(FontAwesomeIcons.sortNumericDown, size: 18.0),
              ),
            ),
            SizedBox(height: 8.0),
            TimePicker(
                hint: 'Opens at: ',
                time: openTime,
                onDateSelected: (TimeOfDay newTime) {
                  setState(() => openTime = newTime);
                  widget.onUpdate();
                }),
            SizedBox(height: 8.0),
            TimePicker(
                hint: 'Closes at: ',
                time: closeTime,
                onDateSelected: (TimeOfDay newTime) {
                  setState(() => closeTime = newTime);
                  widget.onUpdate();
                }),
            SizedBox(height: 8.0),
            SizedBox(
              width: double.infinity,
              child: FlatButton(
                child: Text('Select image'),
                onPressed: () async {
                  var selected =
                      await ImagePicker.pickImage(source: ImageSource.gallery);
                  image = selected;
                  widget.onUpdate();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
