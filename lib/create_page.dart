import 'package:conference/app_bar.dart';
import 'package:conference/conference_room_card.dart';
import 'package:flutter/material.dart';

class CreateConferencePage extends StatefulWidget {
  @override
  _CreateConferencePageState createState() => _CreateConferencePageState();
}

class _CreateConferencePageState extends State<CreateConferencePage> {
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
          child: Container(
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
            child: Column(
              children: [
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}
