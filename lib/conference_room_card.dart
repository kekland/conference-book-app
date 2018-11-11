import 'dart:io';

import 'package:conference/application.dart';
import 'package:conference/icon_text_label.dart';
import 'package:conference/tag_chip.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ConferenceRoomCard extends StatelessWidget {
  final Map raw;
  final File imageFile;
  final String opensAt, closesAt;
  final String name;
  final String cost;
  final String imageURL, location, capacity;
  final List<String> tags;
  final String room;
  final String username;

  const ConferenceRoomCard(
      {Key key,
      this.opensAt,
      this.closesAt,
      this.imageURL,
      this.location,
      this.capacity,
      this.tags,
      this.name,
      this.imageFile,
      this.cost,
      this.room,
      this.username,
      this.raw = null})
      : super(key: key);

  Widget _getImage() {
    if (imageFile != null) {
      return Image.file(imageFile, fit: BoxFit.cover);
    } else if (imageURL != null) {
      return Image.network(imageURL, fit: BoxFit.cover);
    }
    return Container(
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8.0),
          topRight: Radius.circular(8.0),
        ),
      ),
    );
  }

  _book(BuildContext context) {
    Application.tempBooking = raw;
    Application.router.navigateTo(context, '/book');
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Container(
        width: double.infinity,
        child: Column(
          children: [
            // TODO: Image
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 120.0,
                  child: _getImage(),
                  foregroundDecoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.black26, Colors.transparent],
                      begin: Alignment.bottomCenter,
                      end: Alignment.center,
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 120.0,
                  child: Text(name,
                      style: TextStyle(color: Colors.white, fontSize: 18.0)),
                  alignment: Alignment.bottomLeft,
                  padding: const EdgeInsets.only(left: 16.0, bottom: 8.0),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  IconTextLabel(
                    icon: Icon(FontAwesomeIcons.mapMarkerAlt),
                    text: Text(location,
                        style: TextStyle(fontWeight: FontWeight.w500)),
                  ),
                  IconTextLabel(
                    icon: Icon(FontAwesomeIcons.dollarSign),
                    text: Text('${cost}₸ per hour'),
                  ),
                  IconTextLabel(
                    icon: Icon(FontAwesomeIcons.solidClock),
                    text: Text('${opensAt} to ${closesAt}'),
                  ),
                  IconTextLabel(
                    icon: Icon(FontAwesomeIcons.chair),
                    text: Text('${capacity} seats'),
                  ),
                  IconTextLabel(
                    icon: Icon(FontAwesomeIcons.sortNumericDown),
                    text: Text('Room ${room}'),
                  ),
                  IconTextLabel(
                    icon: Icon(FontAwesomeIcons.solidBuilding),
                    text: Text('${username}'),
                  ),
                  Visibility(
                    visible: (raw != null),
                    child: SizedBox(
                      width: double.infinity,
                      child: FlatButton(
                        child: Text('Book'),
                        textColor: Colors.blue,
                        onPressed: () => _book(context),
                      ),
                    ),
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
