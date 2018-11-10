import 'package:conference/application.dart';
import 'package:conference/circular_reveal_widget.dart';
import 'package:conference/conference_room_card.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:rect_getter/rect_getter.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int a = 4;
  var createButtonKey = RectGetter.createGlobalKey();

  openCreatePage(BuildContext context) {
    var center = RectGetter.getRectFromKey(createButtonKey).center;
    Application.router.navigateTo(
      context,
      '/create',
      transition: TransitionType.custom,
      transitionBuilder: (context, animation, _, widget) {
        return PageRevealWidget(
          child: widget,
          revealPercent: animation.value,
          clickPosition: center,
        );
      },
    );
  }

  //Function build
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Conference rooms',
            style: TextStyle(fontFamily: 'Futura', color: Colors.black)),
        elevation: 0.0,
        actions: [
          RectGetter(
            key: createButtonKey,
            child: IconButton(
              icon: Icon(Icons.add),
              onPressed: () => openCreatePage(context),
              color: Colors.blue,
            ),
          ),
        ],
        backgroundColor: Colors.white,
      ),
      body: Container(
        color: Colors.white,
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
