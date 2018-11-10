import 'package:conference/conference_room_card.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int a = 4;
  //Function build
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Conference rooms', style: TextStyle(fontFamily: 'Futura')),
        elevation: 0.0,
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        color: Theme.of(context).primaryColor,
        child: ListView.builder(
          itemBuilder: (context, index) {
            return ConferenceRoomCard();
          },
          padding: const EdgeInsets.all(16.0),
          physics: BouncingScrollPhysics(),
        ),
      ),
    );
  }
}
