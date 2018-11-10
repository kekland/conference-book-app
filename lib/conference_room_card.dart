import 'package:conference/icon_text_label.dart';
import 'package:conference/tag_chip.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ConferenceRoomCard extends StatefulWidget {
  _ConferenceRoomCardState createState() => _ConferenceRoomCardState();
}

class _ConferenceRoomCardState extends State<ConferenceRoomCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Container(
        width: double.infinity,
        child: Column(
          children: [
            // TODO: Image
            Container(
              width: double.infinity,
              height: 120.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8.0),
                    topRight: Radius.circular(8.0)),
                color: Colors.pink,
              ),
              foregroundDecoration: BoxDecoration(
                  gradient: LinearGradient(
                colors: [Colors.black26, Colors.transparent],
                begin: Alignment.bottomCenter,
                end: Alignment.center,
              )),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  IconTextLabel(
                    icon: Icon(FontAwesomeIcons.mapMarkerAlt),
                    text: Text('Baizakova, 280',
                        style: TextStyle(fontWeight: FontWeight.w500)),
                  ),
                  IconTextLabel(
                    icon: Icon(FontAwesomeIcons.solidClock),
                    text: Text('5:00 to 19:00'),
                  ),
                  IconTextLabel(
                    icon: Icon(FontAwesomeIcons.chair),
                    text: Text('200 seats'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Wrap(children: [
                      TagChip(
                        label: Text('Amenities',
                            style: TextStyle(color: Colors.white)),
                        backgroundColor: Colors.blue,
                      ),
                      TagChip(
                        label: Text('Coffee',
                            style: TextStyle(color: Colors.white)),
                        backgroundColor: Colors.purple,
                      ),
                      TagChip(
                        label:
                            Text('Food', style: TextStyle(color: Colors.white)),
                        backgroundColor: Colors.deepOrange,
                      ),
                      TagChip(
                        label: Text('Microphone',
                            style: TextStyle(color: Colors.white)),
                        backgroundColor: Colors.green,
                      ),
                    ]),
                  ),
                ],
                crossAxisAlignment: CrossAxisAlignment.start,
              ),
            ),
          ],
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
        ),
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
      ),
    );
  }
}
