import 'package:conference/api.dart';
import 'package:conference/application.dart';
import 'package:conference/circular_reveal_widget.dart';
import 'package:conference/conference_room_card.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:rect_getter/rect_getter.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int a = 4;
  var createButtonKey = RectGetter.createGlobalKey();
  var scaffoldKey = new GlobalKey<ScaffoldState>();
  List data = null;
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

  @override
  initState() {
    super.initState();
    _getData();
  }

  _getData() async {
    data = null;
    setState(() {});
    try {
      data = await API.getConferences();
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
        itemBuilder: (context, index) {
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
        itemCount: data.length,
        padding: const EdgeInsets.all(16.0),
        physics: BouncingScrollPhysics(),
      );
    }
  }

  //Function build
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: Center(
          child: GestureDetector(
            onTap: () {
              Application.router.navigateTo(context,
                  '/profile/' + Application.prefs.getString("username"));
            },
            child: Container(
              width: 36.0,
              height: 36.0,
              alignment: Alignment.center,
              child: Text(
                  Application.prefs.getString("username")[0].toUpperCase(),
                  style: TextStyle(color: Colors.white)),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue,
              ),
            ),
          ),
        ),
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
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () => _getData(),
            color: Colors.blue,
          ),
        ],
        backgroundColor: Colors.white,
      ),
      body: Container(color: Colors.white, child: _getBody()),
    );
  }
}
