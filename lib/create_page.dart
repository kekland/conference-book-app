import 'dart:io';

import 'package:conference/app_bar.dart';
import 'package:conference/conference_room_card.dart';
import 'package:conference/time_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

class CreateConferencePage extends StatefulWidget {
  @override
  _CreateConferencePageState createState() => _CreateConferencePageState();
}

class _CreateConferencePageState extends State<CreateConferencePage> {
  GlobalKey<DataCardState> dataCardKey = new GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Share your conference room',
            style: TextStyle(fontFamily: 'Futura', color: Colors.black)),
        elevation: 0.0,
        backgroundColor: Colors.white,
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
                location: (dataCardKey.currentState != null &&
                        dataCardKey.currentState.location != null)
                    ? dataCardKey.currentState.location
                    : "Empty",
                capacity: (dataCardKey.currentState != null &&
                        dataCardKey.currentState.capacity != null)
                    ? dataCardKey.currentState.capacity
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
  String name, location, capacity;
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
            )
          ],
        ),
      ),
    );
  }
}
